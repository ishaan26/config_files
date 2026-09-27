# Helper scripts behind the custom/* waybar modules.
#
# Contract (waybar 0.15 custom module):
#   * interval scripts print one JSON object and exit; a non-zero exit hides
#     the module, so hardware that is absent on a host (no AMD GPU on the
#     aarch64 box, no hwmon CPU sensor in a VM) never renders an "N/A" chip.
#   * continuous scripts (weather) print one JSON object per line and hide the
#     module by emitting an empty `text`.
#   * every external binary is referenced by store path, so behaviour does not
#     depend on the PATH of the systemd user unit that launches waybar.
{ pkgs }:
let
  jq = "${pkgs.jq}/bin/jq";
  curl = "${pkgs.curl}/bin/curl";
  pkill = "${pkgs.procps}/bin/pkill";
in
rec {
  # Refresh a `signal = N` custom module. The binary is wrapped, so the
  # process is called `.waybar-wrapped`; match both names exactly so helper
  # scripts that merely contain "waybar" in their name never get the signal.
  refresh = signal: "${pkill} -RTMIN+${toString signal} -x '\\.?waybar(-wrapped)?'";

  # CPU package temperature. hwmon indices change across boots while driver
  # names do not, so the sensor is found by name (AMD k10temp/zenpower, Intel
  # coretemp, ARM cpu_thermal). The tooltip lists every labelled sensor
  # (Tctl, Tccd1, ...). `percentage` drives the thermometer icon ramp.
  cpuTemperature = pkgs.writeShellScript "waybar-cpu-temperature" ''
    set -u

    dir=""
    for want in k10temp zenpower coretemp cpu_thermal; do
      for f in /sys/class/hwmon/hwmon*/name; do
        [ "$(cat "$f" 2>/dev/null)" = "$want" ] && dir="''${f%/name}" && break 2
      done
    done
    [ -n "$dir" ] || exit 1

    raw=$(cat "$dir/temp1_input" 2>/dev/null)
    case "$raw" in "" | *[!0-9]*) exit 1 ;; esac
    temp=$((raw / 1000))

    class="normal"
    if [ "$temp" -ge 85 ]; then class="critical"
    elif [ "$temp" -ge 72 ]; then class="warning"
    fi

    tooltip="<b>CPU temperature</b>\n"
    for f in "$dir"/temp*_label; do
      [ -e "$f" ] || continue
      n="''${f##*/temp}"
      n="''${n%_label}"
      v=$(cat "$dir/temp''${n}_input" 2>/dev/null)
      case "$v" in "" | *[!0-9]*) continue ;; esac
      d=$((v / 100))
      tooltip="$tooltip\n$(cat "$f")\t$((d / 10)).$((d % 10))°C"
    done

    pct=$temp
    [ "$pct" -gt 100 ] && pct=100
    printf '{"text":"%2d°C","tooltip":"%s","class":"%s","percentage":%d}\n' \
      "$temp" "$tooltip" "$class" "$pct"
  '';

  # AMD GPU: picks the amdgpu card with the most VRAM (so an iGPU never wins
  # over the dGPU) and reads load, VRAM, temperatures, clocks and power
  # straight from sysfs - no ROCm/radeontop dependency, ~1ms per run.
  amdGpu = pkgs.writeShellScript "waybar-amd-gpu" ''
    set -u

    num() { v=$(cat "$1" 2>/dev/null); case "$v" in "" | *[!0-9]*) echo "" ;; *) echo "$v" ;; esac; }
    gib() { t=$(($1 * 10 / 1073741824)); echo "$((t / 10)).$((t % 10))"; }

    dev="" total=0
    for d in /sys/class/drm/card*/device; do
      [ "$(cat "$d/vendor" 2>/dev/null)" = "0x1002" ] || continue
      t=$(num "$d/mem_info_vram_total")
      [ -n "$t" ] && [ "$t" -gt "$total" ] && total=$t && dev=$d
    done
    [ -n "$dev" ] || exit 1

    busy=$(num "$dev/gpu_busy_percent"); busy=''${busy:-0}
    used=$(num "$dev/mem_info_vram_used"); used=''${used:-0}
    vpct=$((used * 100 / total))

    edge="" junction="" mem="" power="" sclk=""
    for hw in "$dev"/hwmon/hwmon*; do
      [ -d "$hw" ] || continue
      for lbl in "$hw"/temp*_label; do
        [ -e "$lbl" ] || continue
        v=$(num "''${lbl%_label}_input")
        [ -n "$v" ] || continue
        case "$(cat "$lbl")" in
          edge) edge=$((v / 1000)) ;;
          junction) junction=$((v / 1000)) ;;
          mem) mem=$((v / 1000)) ;;
        esac
      done
      for f in power1_average power1_input; do
        v=$(num "$hw/$f")
        [ -n "$v" ] && power=$((v / 1000000)) && break
      done
      v=$(num "$hw/freq1_input")
      [ -n "$v" ] && sclk=$((v / 1000000))
    done

    class="normal"
    if [ "$busy" -ge 95 ] || [ "$vpct" -ge 95 ]; then class="critical"
    elif [ "$busy" -ge 80 ] || [ "$vpct" -ge 85 ]; then class="warning"
    fi

    tooltip="<b>GPU</b>\n"
    tooltip="$tooltip\nLoad\t\t''${busy}%"
    tooltip="$tooltip\nVRAM\t\t$(gib "$used") / $(gib "$total") GiB (''${vpct}%)"
    [ -n "$sclk" ] && tooltip="$tooltip\nCore clock\t''${sclk} MHz"
    [ -n "$power" ] && tooltip="$tooltip\nPower\t\t''${power} W"
    [ -n "$edge" ] && tooltip="$tooltip\nEdge\t\t''${edge}°C"
    [ -n "$junction" ] && tooltip="$tooltip\nJunction\t''${junction}°C"
    [ -n "$mem" ] && tooltip="$tooltip\nMemory\t''${mem}°C"

    printf '{"text":"%2d%%","tooltip":"%s","class":"%s","percentage":%d}\n' \
      "$busy" "$tooltip" "$class" "$busy"
  '';

  # mako do-not-disturb state (the `mode=do-not-disturb` criteria in
  # mako.nix makes notifications invisible). Exits 1 while mako is not
  # running so the bell disappears instead of lying about the state.
  notifications = pkgs.writeShellScript "waybar-notifications" ''
    set -u
    modes=$(${pkgs.mako}/bin/makoctl mode 2>/dev/null) || exit 1
    if printf '%s\n' "$modes" | ${pkgs.gnugrep}/bin/grep -qx do-not-disturb; then
      printf '{"text":"dnd","alt":"dnd","class":"dnd","tooltip":"<b>Do not disturb</b>\\nNotifications are hidden\\n\\nClick  resume\\nRight  restore last\\nMiddle  dismiss all"}\n'
    else
      printf '{"text":"on","alt":"on","class":"on","tooltip":"<b>Notifications</b>\\n\\nClick  do not disturb\\nRight  restore last\\nMiddle  dismiss all"}\n'
    fi
  '';

  toggleDnd = pkgs.writeShellScript "waybar-toggle-dnd" ''
    ${pkgs.mako}/bin/makoctl mode -t do-not-disturb >/dev/null
    ${refresh 8}
  '';

  # Colour picker built on niri's own picker (no hyprpicker/grim needed).
  pickColor = pkgs.writeShellScript "waybar-pick-color" ''
    set -u
    hex=$(${pkgs.niri}/bin/niri msg pick-color 2>/dev/null \
      | ${pkgs.gnugrep}/bin/grep -oE '#[0-9A-Fa-f]{6}' | head -n1)
    [ -n "$hex" ] || exit 0
    printf '%s' "$hex" | ${pkgs.wl-clipboard}/bin/wl-copy
    ${pkgs.libnotify}/bin/notify-send -a Waybar -i color-select "Colour picked" "$hex copied to clipboard"
  '';

  # Clipboard history picker (cliphist is fed by services.cliphist).
  clipboard = pkgs.writeShellScript "waybar-clipboard" ''
    set -u
    ${pkgs.cliphist}/bin/cliphist list \
      | rofi -dmenu -i -display-columns 2 -p '󰅌  Clipboard' \
      | ${pkgs.cliphist}/bin/cliphist decode \
      | ${pkgs.wl-clipboard}/bin/wl-copy
  '';

  clearClipboard = pkgs.writeShellScript "waybar-clipboard-clear" ''
    ${pkgs.cliphist}/bin/cliphist wipe
    ${pkgs.libnotify}/bin/notify-send -a Waybar -i edit-clear "Clipboard" "History cleared"
  '';

  # Dock launcher: focus the newest window whose app-id matches the regex,
  # otherwise start the app. Spawned through niri so it is fully detached
  # from waybar (survives bar restarts) and gets the session environment.
  focusOrLaunch = pkgs.writeShellScript "waybar-focus-or-launch" ''
    set -u
    pattern=$1
    shift
    id=$(${pkgs.niri}/bin/niri msg --json windows 2>/dev/null \
      | ${jq} -r --arg re "$pattern" \
          '[.[] | select(.app_id // "" | test($re; "i"))] | max_by(.id) | .id // empty')
    if [ -n "$id" ]; then
      exec ${pkgs.niri}/bin/niri msg action focus-window --id "$id"
    fi
    exec ${pkgs.niri}/bin/niri msg action spawn -- "$@"
  '';

  # Screen recorder (wf-recorder over wlr-screencopy, which niri supports).
  #   recorder region   select an area with slurp
  #   recorder screen   the focused output
  #   recorder audio    the focused output plus desktop audio
  # Invoked again while recording, it stops and finalises the file.
  # State lives in $XDG_RUNTIME_DIR so a crashed session never leaves it stale.
  recorder = pkgs.writeShellScript "waybar-recorder" ''
    set -u
    state="''${XDG_RUNTIME_DIR:-/tmp}/waybar-recorder"
    notify="${pkgs.libnotify}/bin/notify-send -a Waybar"

    pid=$(cat "$state/pid" 2>/dev/null)
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      kill -INT "$pid"
      # wf-recorder needs a moment to write the mp4 index.
      i=0
      while kill -0 "$pid" 2>/dev/null && [ "$i" -lt 100 ]; do
        sleep 0.1
        i=$((i + 1))
      done
      file=$(cat "$state/file")
      rm -rf "$state"
      ${refresh 9}
      $notify -i video-x-generic "Recording saved" "''${file##*/}"
      exit 0
    fi
    rm -rf "$state"

    output=$(${pkgs.niri}/bin/niri msg --json focused-output | ${jq} -r '.name')
    case "''${1:-region}" in
      region)
        geometry=$(${pkgs.slurp}/bin/slurp -d) || exit 0
        set -- -g "$geometry"
        ;;
      screen)
        set -- -o "$output"
        ;;
      audio)
        sink=$(${pkgs.pulseaudio}/bin/pactl get-default-sink)
        set -- -o "$output" --audio="$sink.monitor"
        ;;
    esac

    dir="$HOME/Videos/Recordings"
    mkdir -p "$dir" "$state"
    file="$dir/Recording $(date '+%Y-%m-%d %H-%M-%S').mp4"

    setsid ${pkgs.wf-recorder}/bin/wf-recorder "$@" -f "$file" >"$state/log" 2>&1 </dev/null &
    echo $! >"$state/pid"
    printf '%s\n' "$file" >"$state/file"
    date +%s >"$state/start"
    ${refresh 9}
  '';

  recorderStatus = pkgs.writeShellScript "waybar-recorder-status" ''
    set -u
    state="''${XDG_RUNTIME_DIR:-/tmp}/waybar-recorder"
    pid=$(cat "$state/pid" 2>/dev/null)
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      el=$(( $(date +%s) - $(cat "$state/start") ))
      file=$(cat "$state/file")
      printf '{"text":"%02d:%02d","alt":"recording","class":"recording","tooltip":"<b>Recording</b>  %02d:%02d\\n%s\\n\\nClick  stop and save"}\n' \
        $((el / 60)) $((el % 60)) $((el / 60)) $((el % 60)) "''${file##*/}"
    else
      # wf-recorder died on its own (e.g. output unplugged): drop the state.
      [ -d "$state" ] && rm -rf "$state"
      printf '{"text":"","alt":"idle","class":"idle","tooltip":"<b>Screen recorder</b>\\nSaves to ~/Videos/Recordings\\n\\nClick  region\\nRight  screen\\nMiddle  screen + audio"}\n'
    fi
  '';

  # Weather, as a long-running script:
  #   * refreshes every 30 min, retries every 2 min while offline (e.g. at
  #     boot before the network is up) instead of vanishing for half an hour;
  #   * keeps showing the cached reading (marked stale) for up to 3 h;
  #   * SIGUSR1 forces an immediate refresh (bound to right-click).
  weather = pkgs.writeShellScript "waybar-weather" ''
    set -u

    cache="''${XDG_CACHE_HOME:-$HOME/.cache}/waybar/weather.json"
    mkdir -p "''${cache%/*}"

    render() {
      ${jq} -c --argjson stale "$1" '
        def esc: tostring | gsub("&"; "&amp;") | gsub("<"; "&lt;") | gsub(">"; "&gt;");
        def mins: try (strptime("%I:%M %p") | .[3] * 60 + .[4]) catch null;
        def icon($code; $day):
          ($code | tonumber) as $c
          | if   $c == 113 then (if $day then "󰖙" else "󰖔" end)
            elif $c == 116 then (if $day then "󰖕" else "󰼱" end)
            elif [119, 122] | index($c) then "󰖐"
            elif [143, 149, 248, 260] | index($c) then "󰖑"
            elif [200, 386, 389, 392, 395] | index($c) then "󰙾"
            elif [179, 182, 185, 227, 230, 281, 284, 311, 314, 317, 320, 323,
                  326, 329, 332, 335, 338, 350, 362, 365, 368, 371, 374, 377]
                 | index($c) then "󰼶"
            elif [299, 302, 305, 308, 356, 359] | index($c) then "󰖖"
            elif [176, 263, 266, 293, 296, 353] | index($c) then "󰖗"
            else "󰖐"
            end;

        .current_condition[0] as $c
        | .nearest_area[0] as $a
        | .weather[0].astronomy[0] as $astro
        # wttr.in only reports the observation time in UTC; sunrise/sunset
        # are local, so compare against the local wall clock.
        | (now | localtime | .[3] * 60 + .[4]) as $now
        | (($astro.sunrise | mins) as $rise | ($astro.sunset | mins) as $set
           | ($rise == null or $set == null or ($now >= $rise and $now < $set))) as $day
        | ($c.weatherDesc[0].value | sub("\\s+$"; "")) as $desc
        | icon($c.weatherCode; $day) as $ic
        | {
            text: "\($ic)\u2009 \($c.temp_C)°",
            alt: (if $stale then "stale" else "fresh" end),
            class: (if $stale then "stale" else "fresh" end),
            tooltip: (
              "<b>\($ic)  \($c.temp_C)°C  \($desc | esc)</b>\n"
              + "\($a.areaName[0].value | esc), \($a.country[0].value | esc)\n\n"
              + "Feels like\t\($c.FeelsLikeC)°C\n"
              + "Humidity\t\($c.humidity)%\n"
              + "Wind\t\t\($c.windspeedKmph) km/h \($c.winddir16Point)\n"
              + "UV index\t\($c.uvIndex)\n"
              + "Daylight\t󰖜 \($astro.sunrise)  󰖛 \($astro.sunset)\n\n"
              + ([.weather[] | "<b>\(.date | strptime("%Y-%m-%d") | strftime("%a %d"))</b>\t"
                   + "\(icon(.hourly[4].weatherCode; true))  \(.mintempC)° – \(.maxtempC)°  "
                   + "<span alpha=\"60%\">\(.hourly[4].weatherDesc[0].value | sub("\\s+$"; "") | esc)</span>"]
                 | join("\n"))
              + (if $stale then "\n\n<i>Offline — showing last reading</i>" else "" end)
              + "\n\n<span alpha=\"60%\">Click  full forecast · Right  refresh</span>"
            )
          }
      ' "$cache"
    }

    sleeper=""
    wake() { [ -n "$sleeper" ] && kill "$sleeper" 2>/dev/null; }
    trap wake USR1
    trap 'wake; exit 0' TERM INT HUP

    while :; do
      if ${curl} -sf --max-time 15 -o "$cache.tmp" 'https://wttr.in/?format=j1&lang=en' \
         && ${jq} -e '.current_condition[0].temp_C' "$cache.tmp" >/dev/null 2>&1; then
        mv -f "$cache.tmp" "$cache"
        stale=false delay=1800
      else
        rm -f "$cache.tmp"
        stale=true delay=120
      fi

      age=999999
      [ -s "$cache" ] && age=$(( $(date +%s) - $(stat -c %Y "$cache") ))
      if [ "$age" -lt 10800 ]; then
        render "$stale" || printf '{"text":""}\n'
      else
        printf '{"text":""}\n'
      fi

      sleep "$delay" &
      sleeper=$!
      wait "$sleeper" 2>/dev/null
      sleeper=""
    done
  '';
}

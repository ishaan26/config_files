# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_cargo_global_optspecs
	string join \n h/help
end

function __fish_cargo_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_cargo_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_cargo_using_subcommand
	set -l cmd (__fish_cargo_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c cargo -n "__fish_cargo_needs_command" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_needs_command" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c cargo -n "__fish_cargo_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "dev" -d 'Run your app in development mode'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "android" -d 'Android commands'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "ios" -d 'iOS commands'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s d -l directory -d 'Set target directory for init' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s t -l tauri-path -d 'Path of the Tauri project to use (relative to the cwd)' -r -F
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s A -l app-name -d 'Name of your Tauri application' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s W -l window-title -d 'Window title of your Tauri application' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s D -l frontend-dist -d 'Web assets location, relative to <project-dir>/src-tauri' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s P -l dev-url -d 'Url of your dev server' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -l before-dev-command -d 'A shell command to run before `tauri dev` kicks in' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -l before-build-command -d 'A shell command to run before `tauri build` kicks in' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -l ci -d 'Skip prompting for values'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s f -l force -d 'Force init to overwrite the src-tauri folder'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s l -l log -d 'Enables logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from init" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s r -l runner -d 'Binary to use to run the application' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s t -l target -d 'Target triple to build against' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s f -l features -d 'List of cargo features to activate' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l port -d 'Specify port for the built-in dev server for static files. Defaults to 1430' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s e -l exit-on-panic -d 'Exit on panic'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l release -d 'Run the code in release mode'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-dev-server-wait -d 'Skip waiting for the frontend dev server to start before building the tauri application'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-watch -d 'Disable the file watcher'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-dev-server -d 'Disable the built-in dev server for static files'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s r -l runner -d 'Binary to use to build the application, defaults to `cargo`' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s t -l target -d 'Target triple to build against' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s f -l features -d 'Space or comma separated list of features to activate' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s b -l bundles -d 'Space or comma separated list of bundles to package' -r -f -a "{ios\t'',app\t'',dmg\t'',updater\t''}"
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s d -l debug -d 'Builds with the debug flag'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -l no-bundle -d 'Skip the bundling step even if `bundle > active` is `true` in tauri config'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -l ci -d 'Skip prompting for values'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from build" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s b -l bundles -d 'Space or comma separated list of bundles to package' -r -f -a "{ios\t'',app\t'',dmg\t'',updater\t''}"
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s f -l features -d 'Space or comma separated list of features, should be the same features passed to `tauri build` if any' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s t -l target -d 'Target triple to build against' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s d -l debug -d 'Builds with the debug flag'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -l ci -d 'Skip prompting for values'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "init" -d 'Initialize Android target in the project'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "dev" -d 'Run your app in development mode on Android'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "build" -d 'Build your app in release mode for Android and generate APKs and AABs'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "android-studio-script"
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "init" -d 'Initialize iOS target in the project'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "dev" -d 'Run your app in development mode on iOS'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "build" -d 'Build your app in release mode for iOS and generate IPAs'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "xcode-script"
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from info" -l interactive -d 'Interactive mode to apply automatic fixes'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from info" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from info" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from info" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from add" -s t -l tag -d 'Git tag to use' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from add" -s r -l rev -d 'Git rev to use' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from add" -s b -l branch -d 'Git branch to use' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from add" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from add" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "new" -d 'Initializes a new Tauri plugin project'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "init" -d 'Initialize a Tauri plugin project on an existing directory'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "android" -d 'Manage the Android project for a Tauri plugin'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "ios" -d 'Manage the iOS project for a Tauri plugin'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s o -l output -d 'Output directory. Default: \'icons\' directory next to the tauri.conf.json file' -r -F
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s p -l png -d 'Custom PNG icon sizes to generate. When set, the default icons are not generated' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from icon" -l ios-color -d 'The background color of the iOS icon - string as defined in the W3C\'s CSS Color Module Level 4 <https://www.w3.org/TR/css-color-4/>' -r
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "sign" -d 'Sign a file'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "generate" -d 'Generate a new signing key to sign files'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s s -l shell -d 'Shell to generate a completion script for.' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s o -l output -d 'Output file for the shell completions. By default the completions are printed to stdout' -r -F
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "new" -d 'Create a new permission file'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "add" -d 'Add a permission to capabilities'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "rm" -d 'Remove a permission file, and its reference from any capability'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "ls" -d 'List permissions available to your application'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s v -l verbose -d 'Enables verbose logging'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s h -l help -d 'Print help'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s V -l version -d 'Print version'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from capability" -f -a "new" -d 'Create a new permission file'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from capability" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "dev" -d 'Run your app in development mode'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "android" -d 'Android commands'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "ios" -d 'iOS commands'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c cargo -n "__fish_cargo_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand help; and not __fish_seen_subcommand_from tauri help" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c cargo -n "__fish_cargo_using_subcommand help; and not __fish_seen_subcommand_from tauri help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "dev" -d 'Run your app in development mode'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "android" -d 'Android commands'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "ios" -d 'iOS commands'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c cargo -n "__fish_cargo_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "capability" -d 'Manage or create capabilities for your app'

# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_pnpm_global_optspecs
	string join \n h/help
end

function __fish_pnpm_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_pnpm_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_pnpm_using_subcommand
	set -l cmd (__fish_pnpm_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c pnpm -n "__fish_pnpm_needs_command" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_needs_command" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c pnpm -n "__fish_pnpm_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "dev" -d 'Run your app in development mode'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "android" -d 'Android commands'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "ios" -d 'iOS commands'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s d -l directory -d 'Set target directory for init' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s t -l tauri-path -d 'Path of the Tauri project to use (relative to the cwd)' -r -F
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s A -l app-name -d 'Name of your Tauri application' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s W -l window-title -d 'Window title of your Tauri application' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s D -l frontend-dist -d 'Web assets location, relative to <project-dir>/src-tauri' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s P -l dev-url -d 'Url of your dev server' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -l before-dev-command -d 'A shell command to run before `tauri dev` kicks in' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -l before-build-command -d 'A shell command to run before `tauri build` kicks in' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -l ci -d 'Skip prompting for values'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s f -l force -d 'Force init to overwrite the src-tauri folder'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s l -l log -d 'Enables logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from init" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s r -l runner -d 'Binary to use to run the application' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s t -l target -d 'Target triple to build against' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s f -l features -d 'List of cargo features to activate' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l port -d 'Specify port for the built-in dev server for static files. Defaults to 1430' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s e -l exit-on-panic -d 'Exit on panic'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l release -d 'Run the code in release mode'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-dev-server-wait -d 'Skip waiting for the frontend dev server to start before building the tauri application'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-watch -d 'Disable the file watcher'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-dev-server -d 'Disable the built-in dev server for static files'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s r -l runner -d 'Binary to use to build the application, defaults to `cargo`' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s t -l target -d 'Target triple to build against' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s f -l features -d 'Space or comma separated list of features to activate' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s b -l bundles -d 'Space or comma separated list of bundles to package' -r -f -a "{ios\t'',app\t'',dmg\t'',updater\t''}"
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s d -l debug -d 'Builds with the debug flag'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -l no-bundle -d 'Skip the bundling step even if `bundle > active` is `true` in tauri config'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -l ci -d 'Skip prompting for values'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from build" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s b -l bundles -d 'Space or comma separated list of bundles to package' -r -f -a "{ios\t'',app\t'',dmg\t'',updater\t''}"
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s f -l features -d 'Space or comma separated list of features, should be the same features passed to `tauri build` if any' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s t -l target -d 'Target triple to build against' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s d -l debug -d 'Builds with the debug flag'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -l ci -d 'Skip prompting for values'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "init" -d 'Initialize Android target in the project'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "dev" -d 'Run your app in development mode on Android'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "build" -d 'Build your app in release mode for Android and generate APKs and AABs'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "android-studio-script"
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "init" -d 'Initialize iOS target in the project'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "dev" -d 'Run your app in development mode on iOS'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "build" -d 'Build your app in release mode for iOS and generate IPAs'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "xcode-script"
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from info" -l interactive -d 'Interactive mode to apply automatic fixes'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from info" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from info" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from info" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from add" -s t -l tag -d 'Git tag to use' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from add" -s r -l rev -d 'Git rev to use' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from add" -s b -l branch -d 'Git branch to use' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from add" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from add" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "new" -d 'Initializes a new Tauri plugin project'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "init" -d 'Initialize a Tauri plugin project on an existing directory'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "android" -d 'Manage the Android project for a Tauri plugin'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "ios" -d 'Manage the iOS project for a Tauri plugin'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s o -l output -d 'Output directory. Default: \'icons\' directory next to the tauri.conf.json file' -r -F
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s p -l png -d 'Custom PNG icon sizes to generate. When set, the default icons are not generated' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from icon" -l ios-color -d 'The background color of the iOS icon - string as defined in the W3C\'s CSS Color Module Level 4 <https://www.w3.org/TR/css-color-4/>' -r
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "sign" -d 'Sign a file'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "generate" -d 'Generate a new signing key to sign files'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s s -l shell -d 'Shell to generate a completion script for.' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s o -l output -d 'Output file for the shell completions. By default the completions are printed to stdout' -r -F
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "new" -d 'Create a new permission file'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "add" -d 'Add a permission to capabilities'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "rm" -d 'Remove a permission file, and its reference from any capability'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "ls" -d 'List permissions available to your application'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s v -l verbose -d 'Enables verbose logging'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s h -l help -d 'Print help'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s V -l version -d 'Print version'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from capability" -f -a "new" -d 'Create a new permission file'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from capability" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "dev" -d 'Run your app in development mode'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "android" -d 'Android commands'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "ios" -d 'iOS commands'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c pnpm -n "__fish_pnpm_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and not __fish_seen_subcommand_from tauri help" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and not __fish_seen_subcommand_from tauri help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "dev" -d 'Run your app in development mode'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "android" -d 'Android commands'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "ios" -d 'iOS commands'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c pnpm -n "__fish_pnpm_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "capability" -d 'Manage or create capabilities for your app'

# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_npm_global_optspecs
	string join \n h/help
end

function __fish_npm_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_npm_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_npm_using_subcommand
	set -l cmd (__fish_npm_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c npm -n "__fish_npm_needs_command" -s h -l help -d 'Print help'
complete -c npm -n "__fish_npm_needs_command" -f -a "run"
complete -c npm -n "__fish_npm_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c npm -n "__fish_npm_using_subcommand run; and not __fish_seen_subcommand_from tauri help" -s h -l help -d 'Print help'
complete -c npm -n "__fish_npm_using_subcommand run; and not __fish_seen_subcommand_from tauri help" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c npm -n "__fish_npm_using_subcommand run; and not __fish_seen_subcommand_from tauri help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -s v -l verbose -d 'Enables verbose logging'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -s h -l help -d 'Print help'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -s V -l version -d 'Print version'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "dev" -d 'Run your app in development mode'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "android" -d 'Android commands'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "ios" -d 'iOS commands'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from help" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c npm -n "__fish_npm_using_subcommand run; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c npm -n "__fish_npm_using_subcommand help; and not __fish_seen_subcommand_from run help" -f -a "run"
complete -c npm -n "__fish_npm_using_subcommand help; and not __fish_seen_subcommand_from run help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c npm -n "__fish_npm_using_subcommand help; and __fish_seen_subcommand_from run" -f -a "tauri" -d 'Command line interface for building Tauri apps'

# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_yarn_global_optspecs
	string join \n h/help
end

function __fish_yarn_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_yarn_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_yarn_using_subcommand
	set -l cmd (__fish_yarn_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c yarn -n "__fish_yarn_needs_command" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_needs_command" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c yarn -n "__fish_yarn_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "dev" -d 'Run your app in development mode'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "android" -d 'Android commands'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "ios" -d 'iOS commands'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and not __fish_seen_subcommand_from init dev build bundle android ios migrate info add plugin icon signer completions permission capability help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s d -l directory -d 'Set target directory for init' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s t -l tauri-path -d 'Path of the Tauri project to use (relative to the cwd)' -r -F
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s A -l app-name -d 'Name of your Tauri application' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s W -l window-title -d 'Window title of your Tauri application' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s D -l frontend-dist -d 'Web assets location, relative to <project-dir>/src-tauri' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s P -l dev-url -d 'Url of your dev server' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -l before-dev-command -d 'A shell command to run before `tauri dev` kicks in' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -l before-build-command -d 'A shell command to run before `tauri build` kicks in' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -l ci -d 'Skip prompting for values'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s f -l force -d 'Force init to overwrite the src-tauri folder'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s l -l log -d 'Enables logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from init" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s r -l runner -d 'Binary to use to run the application' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s t -l target -d 'Target triple to build against' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s f -l features -d 'List of cargo features to activate' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l port -d 'Specify port for the built-in dev server for static files. Defaults to 1430' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s e -l exit-on-panic -d 'Exit on panic'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l release -d 'Run the code in release mode'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-dev-server-wait -d 'Skip waiting for the frontend dev server to start before building the tauri application'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-watch -d 'Disable the file watcher'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -l no-dev-server -d 'Disable the built-in dev server for static files'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from dev" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s r -l runner -d 'Binary to use to build the application, defaults to `cargo`' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s t -l target -d 'Target triple to build against' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s f -l features -d 'Space or comma separated list of features to activate' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s b -l bundles -d 'Space or comma separated list of bundles to package' -r -f -a "{ios\t'',app\t'',dmg\t'',updater\t''}"
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s d -l debug -d 'Builds with the debug flag'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -l no-bundle -d 'Skip the bundling step even if `bundle > active` is `true` in tauri config'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -l ci -d 'Skip prompting for values'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from build" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s b -l bundles -d 'Space or comma separated list of bundles to package' -r -f -a "{ios\t'',app\t'',dmg\t'',updater\t''}"
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s c -l config -d 'JSON string or path to JSON file to merge with tauri.conf.json' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s f -l features -d 'Space or comma separated list of features, should be the same features passed to `tauri build` if any' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s t -l target -d 'Target triple to build against' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s d -l debug -d 'Builds with the debug flag'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -l ci -d 'Skip prompting for values'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from bundle" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "init" -d 'Initialize Android target in the project'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "dev" -d 'Run your app in development mode on Android'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "build" -d 'Build your app in release mode for Android and generate APKs and AABs'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "android-studio-script"
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from android" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "init" -d 'Initialize iOS target in the project'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "dev" -d 'Run your app in development mode on iOS'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "build" -d 'Build your app in release mode for iOS and generate IPAs'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "xcode-script"
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from ios" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from migrate" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from info" -l interactive -d 'Interactive mode to apply automatic fixes'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from info" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from info" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from info" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from add" -s t -l tag -d 'Git tag to use' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from add" -s r -l rev -d 'Git rev to use' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from add" -s b -l branch -d 'Git branch to use' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from add" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from add" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "new" -d 'Initializes a new Tauri plugin project'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "init" -d 'Initialize a Tauri plugin project on an existing directory'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "android" -d 'Manage the Android project for a Tauri plugin'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "ios" -d 'Manage the iOS project for a Tauri plugin'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from plugin" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s o -l output -d 'Output directory. Default: \'icons\' directory next to the tauri.conf.json file' -r -F
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s p -l png -d 'Custom PNG icon sizes to generate. When set, the default icons are not generated' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from icon" -l ios-color -d 'The background color of the iOS icon - string as defined in the W3C\'s CSS Color Module Level 4 <https://www.w3.org/TR/css-color-4/>' -r
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from icon" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from signer" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "sign" -d 'Sign a file'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "generate" -d 'Generate a new signing key to sign files'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from signer" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s s -l shell -d 'Shell to generate a completion script for.' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s o -l output -d 'Output file for the shell completions. By default the completions are printed to stdout' -r -F
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from completions" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "new" -d 'Create a new permission file'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "add" -d 'Add a permission to capabilities'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "rm" -d 'Remove a permission file, and its reference from any capability'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "ls" -d 'List permissions available to your application'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from permission" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s v -l verbose -d 'Enables verbose logging'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s h -l help -d 'Print help'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from capability" -s V -l version -d 'Print version'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from capability" -f -a "new" -d 'Create a new permission file'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from capability" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "dev" -d 'Run your app in development mode'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "android" -d 'Android commands'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "ios" -d 'iOS commands'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c yarn -n "__fish_yarn_using_subcommand tauri; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand help; and not __fish_seen_subcommand_from tauri help" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c yarn -n "__fish_yarn_using_subcommand help; and not __fish_seen_subcommand_from tauri help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "dev" -d 'Run your app in development mode'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "android" -d 'Android commands'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "ios" -d 'iOS commands'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c yarn -n "__fish_yarn_using_subcommand help; and __fish_seen_subcommand_from tauri" -f -a "capability" -d 'Manage or create capabilities for your app'

# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_bun_global_optspecs
	string join \n h/help
end

function __fish_bun_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_bun_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_bun_using_subcommand
	set -l cmd (__fish_bun_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c bun -n "__fish_bun_needs_command" -s h -l help -d 'Print help'
complete -c bun -n "__fish_bun_needs_command" -f -a "run"
complete -c bun -n "__fish_bun_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bun -n "__fish_bun_using_subcommand run; and not __fish_seen_subcommand_from tauri help" -s h -l help -d 'Print help'
complete -c bun -n "__fish_bun_using_subcommand run; and not __fish_seen_subcommand_from tauri help" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c bun -n "__fish_bun_using_subcommand run; and not __fish_seen_subcommand_from tauri help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -s v -l verbose -d 'Enables verbose logging'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -s h -l help -d 'Print help'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -s V -l version -d 'Print version'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "init" -d 'Initialize a Tauri project in an existing directory'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "dev" -d 'Run your app in development mode'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "build" -d 'Build your app in release mode and generate bundles and installers'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "bundle" -d 'Generate bundles and installers for your app (already built by `tauri build`)'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "android" -d 'Android commands'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "ios" -d 'iOS commands'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "migrate" -d 'Migrate from v1 to v2'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "info" -d 'Show a concise list of information about the environment, Rust, Node.js and their versions as well as a few relevant project configurations'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "add" -d 'Add a tauri plugin to the project'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "plugin" -d 'Manage or create Tauri plugins'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "icon" -d 'Generate various icons for all major platforms'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "signer" -d 'Generate signing keys for Tauri updater or sign files'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "completions" -d 'Generate Tauri CLI shell completions for Bash, Zsh, PowerShell or Fish'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "permission" -d 'Manage or create permissions for your app or plugin'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "capability" -d 'Manage or create capabilities for your app'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from tauri" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from help" -f -a "tauri" -d 'Command line interface for building Tauri apps'
complete -c bun -n "__fish_bun_using_subcommand run; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bun -n "__fish_bun_using_subcommand help; and not __fish_seen_subcommand_from run help" -f -a "run"
complete -c bun -n "__fish_bun_using_subcommand help; and not __fish_seen_subcommand_from run help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bun -n "__fish_bun_using_subcommand help; and __fish_seen_subcommand_from run" -f -a "tauri" -d 'Command line interface for building Tauri apps'


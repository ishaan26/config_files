# Linux and Mac configuration files

I have made over 700 commits to this. lol

### Pro Tip

You can soft-link the config files and aliases files to the desired location directly from the git repo so that your changes can be directly uploaded to your Github if you choose to do so.

*In any case, the files will still work if you just copy them to their supposed location*.

```shell
ln -sf <location of original files> <location where is config file is supposed to be placed>
```

## Terminal Themes

##### Dependencies

* [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (For the zsh shell replacing bash)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) (For syntax highlighting in the terminal!)
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) (For fish shell like autosuggestions)
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (For shell the theme)
* [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) (For the glyphs)

### Linux

![p10k-showcase](img/linux/p10k-showcase.png)
![neofetch-p10k-showcase](img/linux/neofetch-p10k-showcase.png)

Terminal: [Konsole](https://github.com/KDE/konsole)

*The blur comes from [compton-tryone](#Compton-tryone)*

#### Steps to install

* Soft Link or copy the `.zshrc` and `.p10k.zsh` files in  `$HOME`
* Run `source ~/.zshrc`
* Make sure the font of the terminal is set to a Nerd Font

### Mac

![p10k](img/mac/p10k.png)
![neofetch](img/mac/neofetch.png)

Terminal: [iTerm2](https://www.iterm2.com/)

#### Steps to install

* Soft Link or copy the `mac/.zshrc` and `.p10k.zsh` files in `$HOME`
* Run `source ~/.zshrc`
* Make sure the font of the terminal is set to a Nerd Font

## bspwm

![1](img/linux/i3-Desktop.png)

[Wallpaper](https://www.wallpapermaiden.com/wallpaper/8457/no-man-s-sky-landscape-artwork-planet-spacecraft/download/1280x800)

![3](img/linux/i3-windows_gapps.png)

#### Steps to install

* Install bspwm, rofi, picom and polybar.
* Soft link or copy the files from `.config` folder to `$HOME/.config`
* Reboot

#### Note

*You need to modify the config files for polybar and bspwm to match your system harware requirements*

### Polybar

![4](img/linux/polybar-Bar_1.png)
![5](img/linux/polybar-Bar_2.png)

### Rofi

The rofi themes are based on - <https://github.com/adi1090x/rofi>

![6](img/linux/Rofi-apps.gif)

![7](img/linux/rofi-widgets.gif)

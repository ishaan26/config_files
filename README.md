# Ubuntu, Mac, Termux and WSL Configuration files

These are all my config files from different systems I use and also some patched nerdfonts. I try to keep this repo updated and add more stuff regularly.

## Table of Contents

1. [Important Notes](#Important-Notes)
2. [Pro Tip](#Pro-Tip)
3. [Ubuntu](#Ubuntu)
    - [Terminal Theme](#Terminal-Theme)

4. Mac
5. WSL
6. Termux

## Important Notes

1. The Polybar config file has only been tested on Acer Predator Helios 300 G-572. Therefore, many modules in it correspond to its hardware only. You will need to change hardware module settings to match your hardware. (see the polybar section for more info)
2. The linux config files have been tested on a fresh install of Ubuntu and XUbuntu 20.04.
3. The mac config files have been tested on Mac Os Catalinia 10.15.4.

## Pro Tip

 You can soft link the config files and aliases files to the desired location directly from the git repo so that your changes can be directly uploaded to your github if you choose to do so.

 *In any case, the files will still work if you just copy them to there supposed location*.

  ```shell
  cd <location to where the file is supposed to be linked>
  ln -sf <location of original files> <name of the linked file>
  ```

## Ubuntu

### Terminal Theme

![p10k-showcase](img/linux/p10k-showcase.png)
![neofetch-p10k-showcase](img/linux/neofetch-p10k-showcase.png)

#### Dependencies

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) (For the zsh shell replacing bash)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) (For syntax highlighting in the terminal!)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (For the theme)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) (For the glyphs)

#### Steps to install

- Place the `linux/.zshrc` and `.p10k.zsh` files in your home folder
- run ```source ~/.zshrc```

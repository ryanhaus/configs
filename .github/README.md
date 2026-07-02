# Configs/dotfiles
This repo contains all my dotfiles and uses [yadm](https://github.com/yadm-dev/yadm) to install all programs and configs.

To use:
 - Install [yadm](https://yadm.io/docs/install) and `python3`
 - Run `yadm clone https://github.com/ryanhaus/configs`

## Fedora quickstart
```sh
dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_43/home:TheLocehiliosan:yadm.repo
sudo dnf install yadm python3
yadm clone https://github.com/ryanhaus/configs
yadm bootstrap
```

# DevTerm hobby project

So I bought this amazing device: [DevTerm A-0604](https://www.clockworkpi.com/devterm). It has a beefy ARM processor and runs a custom version of [Armbian](https://www.armbian.com/), embraces Open Source / Open Hardware phylosophy and looks dope!

It also has LightDM + xfce for UI but I think it's kinda boring to use this retro-looking device with GUI. Let's try to set it up for serious business and full entertainment without any GUI - just how it was in good old days. 

Last Linux distro I've touched (not counting servers) was Red Hat Linux 9 (not RHEL!). I know nothing about modern linuxes and I always forget all that voodoo you have to do with them to make it work. So here I'll storing some notes and useful scripts as I go with my hobby project

![This is an image](./images/devterm.jpg?raw=true)

## Roadmap
- [x] disable GUI 
- [x] enable ssh connection
- [x] connect to home wifi
- [x] basic scripts (battery charge and brightness control)
- [x] render UTF, Cyrillic, Japanese in TTY
- [ ] battery indicator in zsh prompt
- [ ] email client
- [ ] nethack / dcss
- [ ] twitter client
- [ ] hckrnews client
- [ ] reddit client
- [ ] stonks
- [ ] music / spotify player
- [ ] gamepad to scroll text in terminal
- [ ] soluiton for browser
- [ ] start fdterm on load
- [ ] japanese input in tty
- [ ] google translate in terminal

## Notes

1) Terminal. Standard TTY has a very limited capabilities to render fonts. Had troubles to render Japanese characters (kanji, hirogana and katakana). Got success with using `fdterm` with `Iosevka Term` fonts

2) Browser. Had some hopes for [Browsh](https://www.brow.sh/) but it's super slow (uses headless Firefox behind the scenes) and rendering getting borked in `fdterm`

## License 

MIT unless specified otherwise

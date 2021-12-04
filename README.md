# DevTerm hobby project

So I bought this amazing device: [DevTerm A-0604](https://www.clockworkpi.com/devterm). It has ARM processor and runs a custom version of (Armbian)[https://www.armbian.com/]. 

It has LightDM + xfce for UI (I think) but it's boring to use this retro-looking device with GUI. Let's try to set it up for full entertainment without any GUI environment. And store some files / notes here as we go

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

MIT unless specified 

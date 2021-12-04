# DevTerm hobby project

So I bought this amazing device: [DevTerm A-0604](https://www.clockworkpi.com/devterm). It has a beefy ARM processor and runs a custom version of [Armbian](https://www.armbian.com/), embraces Open Source / Open Hardware philosophy and looks dope!

It also has LightDM + xfce for UI but it's kinda boring to use this amazing retro-looking device with graphical interface. **Let's try to set it up for a serious business and a maximum entertainment without any GUI** - just how it was in the good old days. 

Last Linux distro I've touched (not counting servers) was Red Hat Linux 9 (not RHEL!). I know nothing about modern linuxes + I always forget all the voodoo you have to do to make them work. So here I'll be storing my notes and useful scripts as I go with this hobby project

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
- [ ] can I see pictures in the TTY?
- [ ] what about video?
- [ ] music / spotify player
- [ ] gamepad to scroll text in terminal
- [ ] soluiton for browser
- [ ] start fdterm on load
- [ ] japanese input in tty
- [ ] google translate in terminal
- [ ] plug a mini cassette recorder, do some magic to let me store data using cute tiny mini audio-cassettes.. yum!

## Notes

1) Terminal. Standard TTY has a very limited capabilities to render fonts. Had troubles to render Japanese characters (kanji, hirogana and katakana). Got success with using `fdterm` with `Iosevka Term` fonts. Still need to figure out how to autostart it 

2) To connect to WiFi I've tried `wpa_cli` but you need to be really smart to use it. Not my case. Fallbacked to use `nmcli` and it works like a charm

3) Browser. Had some hopes for [Browsh](https://www.brow.sh/) but it's super slow (uses headless Firefox behind the scenes) and rendering getting borked in `fdterm`. Have to use `lynx` for now. And my Macbook...

## License 

MIT unless specified otherwise

# DevTerm hobby project

So I bought this amazing device: [DevTerm A-0604](https://www.clockworkpi.com/devterm). It has a beefy ARM processor and runs a custom version of [Armbian](https://www.armbian.com/), embraces Open Source / Open Hardware philosophy and looks dope!

It also has LightDM + xfce for UI but it's kinda boring to use this amazing retro-looking device with graphical interface. **Let's try to set it up for a serious business and a maximum entertainment without any GUI** - just how it was in the good old days. 

Last Linux distro I've touched (not counting servers) was Red Hat Linux 9 (not RHEL!). I know nothing about modern linuxes + I always forget all the voodoo you have to do to make them work. So here I'll be storing my notes and useful scripts as I go with this hobby project

<img src="./images/devterm.jpg?raw=true" width="500"/>

## Roadmap
- [x] disable GUI 
- [x] enable ssh connection
- [x] connect to home wifi
- [x] basic scripts (battery charge and brightness control)
- [x] render UTF, Cyrillic, Japanese in TTY
- [x] battery indicator in zsh prompt
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
- [x] google translate in terminal
- [ ] plug a mini cassette recorder, do some magic to let me store data using cute tiny mini audio-cassettes.. yum!

## Notes

1) Terminal. Standard TTY has a very limited capabilities to render fonts. Had troubles to render Japanese characters (kanji, hirogana and katakana). Got success with using `fdterm` with [Iosevka Term](https://typeof.net/Iosevka/) and [Noto Sans JP](https://fonts.google.com/noto/specimen/Noto+Sans+JP?subset=japanese) fonts. Downloaded them and copied into `/usr/share/fonts/(truetype|opentype)` and update `~/.fbtermrc`. If the first font doesn't contain the glyph for the rendering character, it will try second font and etc (1). (Still need to try to figure out how to autostart `fdterm`)

2) To connect to WiFi I've tried `wpa_cli` but you need to be really smart to use it. Not my case. Fallbacked to use `nmcli` and it works like a charm

3) Browser. Had some hopes for [Browsh](https://www.brow.sh/) but it's super slow (uses headless Firefox behind the scenes) and rendering getting borked in `fdterm`. Have to use `lynx` for now. And my Macbook...

4) Translations. After quick search was able to find `libtranslate-bin` but there were no builds for ARM64 and I was about to start building it from sources. However, looked for alternatives in the apt repo and found [translate-shell](https://github.com/soimort/translate-shell). Works amazingly well for my needs

5) There is a cool zsh plugin as part of `oh-my-zsh` called [battery](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/battery). To make it work you need to install `acpi` and update your prompt. Works flawlessly

## Screenshots

(1) Translations + JA glyph rendering in fbterm

<img src="./images/en2ja.jpg?raw=true" width="300"/>

## License 

MIT unless specified otherwise

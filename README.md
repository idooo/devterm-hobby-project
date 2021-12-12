# DevTerm hobby project

I bought this amazing device: [DevTerm A-0604](https://www.clockworkpi.com/devterm). It has a beefy ARM processor, runs a custom version of [Armbian](https://www.armbian.com/), embraces Open Source / Open Hardware philosophy and looks dope!

It also has LightDM + xfce as a GUI but it's kinda boring to use this amazing retro-looking device with graphical interface. **Let's try to set it up for a serious business and a maximum entertainment without any GUI** - just how it was in the good old days. 

Last Linux distro I've touched (not counting servers) was Red Hat Linux 9 (not RHEL!). I know nothing about modern linuxes + I always forget all the voodoo you have to do to make them work. So here I'll be storing my notes and useful scripts as I go with this hobby project

<img src="./images/devterm.jpg?raw=true" width="500"/>

## Roadmap
- [x] disable GUI 
- [x] enable ssh connection
- [x] connect to home wifi
- [x] basic scripts (battery charge and brightness control)
- [x] render UTF, Cyrillic, Japanese in TTY
- [x] battery indicator in zsh prompt
- [ ] nice setup for tmux (themes, plugins)
- [ ] email client (gmail, protonmail)
- [x] games: nethack
- [ ] games: dcss
- [ ] twitter client
- [ ] hckrnews client
- [x] reddit client
- [ ] stonks
- [ ] IDE / code editor
- [ ] text editor
- [ ] rust
- [ ] can I see pictures in the TTY?
- [ ] what about video?
- [ ] music / spotify player
- [ ] gamepad to scroll text in terminal
- [ ] soluiton for browser
- [ ] start fdterm+fcitx on load
- [x] bg image in fbterm
- [x] japanese input in tty
- [x] google translate in terminal
- [x] auth by usb stick
- [ ] plug a mini cassette recorder, do some magic to let me store data using cute tiny mini audio-cassettes.. yum!

## Notes

1) Terminal. Standard TTY has a very limited capabilities to render fonts. Had troubles to render Japanese characters (kanji, hirogana and katakana). Got success with using `fdterm` with [Iosevka Term](https://typeof.net/Iosevka/) and [Noto Sans JP](https://fonts.google.com/noto/specimen/Noto+Sans+JP?subset=japanese) fonts. Downloaded them and copied into `/usr/share/fonts/(truetype|opentype)` and update `~/.fbtermrc`. If the first font doesn't contain the glyph for the rendering character, it will try second font and etc (1). (Still need to try to figure out how to autostart `fdterm`)

2) To connect to WiFi I've tried `wpa_cli` but you need to be really smart to use it. Not my case. Fallbacked to use `nmcli` and it works like a charm

3) Browser. Had some hopes for [Browsh](https://www.brow.sh/) but it's super slow (uses headless Firefox behind the scenes) and rendering getting borked in `fdterm`. Have to use `lynx` for now, and my Macbook

4) Translations. After quick search was able to find `libtranslate-bin` but there were no builds for ARM64 and I was about to start building it from sources. However, looked for alternatives in the apt repo and found [translate-shell](https://github.com/soimort/translate-shell). Works amazingly well for my needs

5) There is a cool zsh plugin as part of `oh-my-zsh` called [battery](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/battery). To make it work you need to install `acpi` and update your prompt. Works flawlessly but I want to use battery indicator in `tmux`

6) Games. [DCSS](https://crawl.develz.org/) is a cool roguelike crawler. Doesn't have ARM64 binary, got the [source](https://github.com/crawl/crawl), followed the [instructions](https://github.com/crawl/crawl/blob/master/crawl-ref/INSTALL.md) and built it without any problems. However attempting to start it throws an error `Terminal too small` because it needs min height of 24 lines (DevTerm is only 19). Can try to change [this](https://github.com/crawl/crawl/blob/01218726429e4ea9e687ec3926d8e238243f126e/crawl-ref/source/defines.h#L24) but will that make it unplayable?

7) Used [this guide](https://forum.clockworkpi.com/t/using-gamepad-arrows-and-buttons-in-command-line-apps/7059/2?u=godzil) to change the way gamepad on DevTerm keyboard works

8) Installed `gpm` (using [this](https://www.geeksforgeeks.org/gpm-command-in-linux-with-examples/)) to enable mouse in tty. Didn't need to setup anything. It just works

9) Software - Reddit client. Although [rtv](https://github.com/michael-lazar/rtv) is discontinued - it still works better than alternatives. Can't log in under my user but it doesn't matter much.

10) Games. [Nethack](https://packages.debian.org/sid/games/nethack-console) just works!

11) CPU scaling. Clockworkpi made a [script](https://forum.clockworkpi.com/t/devterm-a-06-core-cpu-frequency-scaling/7135) to adjust CPU/GPU cores dynamically 


## Japanese input method in terminal

I stumbled upon [this good video](https://www.youtube.com/watch?v=lJoXhS4EUJs) where Brodie Robertson talks about input method frameworks, input method engines and shows how to setup `fcitx` with `fcitx-moz` to enable Japanese input method for Arch linux.

However we need to make all of it working in our terminal. Luckily for us there is `fbterm` support and as a double win - we have all needed packages in Armbian repo. So I've installed `sudo apt install fcitx fcitx-mozc fcitx-frontend-fbterm fcitx-ui-classic`.

Configuration in `~/.config/fcitx/config` seems pretty odd. I wasn't able to make it work with any other trigger key except for the default one (Ctrl+Space). However I changed `SwitchKey` to be `L_ALT` (instead of defaule L_SHIFT) and it made my life better.

To be able to use Ctlr+Space combination I had to update permissions for `fbterm` by executing `setcap 'cap_sys_tty_config+ep' /usr/bin/fbterm `

Then to start `fbterm` with `fcitx` you simply run `fcitx-fbterm-helper -l`. Press Ctrl+Space to enable it and then Alt to switch between US and JA input methods. 

<img src="./images/fcitx-moz.jpg?raw=true" width="300"/>

## Set background image in terminal

We have [this good guide](https://askubuntu.com/questions/278863/how-do-i-set-up-a-background-image-for-console) that I followed to make the magic happen. We need to build `fbv` from sources and for that we need to:

- get stock libjpeg dev by using `sudo apt-get install libjpeg-dev`
- build libungif from sources: 
```
git clone https://github.com/Distrotech/libungif.git
autoreconf -f -i
./configure
make 
sudo make install
```
- build old libpng (1.2) because `fbv` doesn't like the latest one Armbian repo has

```
# get .tar.gz from https://sourceforge.net/projects/libpng/
tar xfv <file.tar.gz>
./configure
make 
sudo make install
sudo ldconfig
```

Now it's time to get and build `fbv`:

```
wget http://s-tech.elsat.net.pl/fbv/fbv-1.0b.tar.gz
tar xfv fbv-1.0b.tar.gz
./configure
sudo checkinstall
```

Now according to the `fbterm` [manual](https://linux.die.net/man/1/fbterm), this is the script we can create to run fbterm with the background image:

```
#!/bin/bash

# fbterm-bi: a wrapper script to enable background image with fbterm
# usage: fbterm-bi /path/to/image fbterm-options

echo -ne "\e[?25l" # hide cursor

fbv -ciuker "$1" << EOF
q
EOF

shift
export FBTERM_BACKGROUND_IMAGE=1
exec fbterm "$@"
```

I've slightly modified it and put in this repo as `./scripts/fbstart`. Remember, we actually don't start `fbterm` directly but run it via `fcitx-fbterm-helper` instead. If you are doing the same thing, you would also would like to edit `/usr/bin/fcitx-fbterm-helper` to comment all `echo` lines there. Otherwise those messages will become the part of your background.

One more thing: for some reason my `fbterm` requires a counter clockwise rotation to render itself correctly, so I had to rotate the image as well.

At the end it looks like this:

<img src="./images/bgc-image.jpg?raw=true" width="600"/>

## Login & sudo via Yubikey (USB Security Key)

I have [Yubikey 5 NFC](https://www.yubico.com/products/yubikey-5-overview/) so it was logical to set it up with DevTerm. 

First you need to generate One Time Password (OTP) and upload it to [Yubikey Cloud](https://upload.yubico.com/), then you have to generate [API keys](https://upgrade.yubico.com/getapikey/) - store it somewhere secure. 

For the same step you can download and use Yubikey Manager app on your other machine. I used it to setup long button press on a key to return the OTP

Then you will have to get [yubico-pam](https://github.com/Yubico/yubico-pam). I've built it myself following the instruction in the README. But to do that you will have to build a fee other dependencies first. Namely 
[yubico-c](https://developers.yubico.com/yubico-c/) and [yubico-c-client](https://developers.yubico.com/yubico-c-client/) 

And to build them I had to install quite a few libraries (maybe even missing something):

```
sudo apt-get install libcurl4-openssl-dev libpam-dev help2man libxslt1-dev docbook-xsl xsltproc libxml2-utils asciidoc
```

After that follow the configuration instructions for [yubico-pam](https://github.com/Yubico/yubico-pam#configuration), add to `/etc/pam.d/sudo` and `/etc/pam.d/login` this (you can remove `debug` later after you verify that it works: 

```
auth sufficient pam_yubico.so id=[Your API ID] debug
```

then create `~/.yubico/authorized_yubikeys` with your username and Yubikey ID (that's the info from "Public identity" field when you generate your OTP password)

```
username:<Yubikey ID>
```

then move `pam_yubico.so` to `/lib/security/`

```
mv /usr/local/lib/security/pam_yubico.so /lib/security/
```

and that's it! Next time you login/sudo you will prompted by `YubiKey for 'USERNAME':` and you just need to simply touch your key. You should see something like this:

```
debug: pam_yubico.c:943 (parse_cfg): called.
debug: pam_yubico.c:944 (parse_cfg): flags 32768 argc 2
debug: pam_yubico.c:946 (parse_cfg): argv[0]=id=00000
debug: pam_yubico.c:946 (parse_cfg): argv[1]=debug
debug: pam_yubico.c:947 (parse_cfg): id=00000
debug: pam_yubico.c:948 (parse_cfg): key=(null)
debug: pam_yubico.c:949 (parse_cfg): debug=1
debug: pam_yubico.c:950 (parse_cfg): debug_file=1
debug: pam_yubico.c:951 (parse_cfg): alwaysok=0
debug: pam_yubico.c:952 (parse_cfg): verbose_otp=0
debug: pam_yubico.c:953 (parse_cfg): try_first_pass=0
debug: pam_yubico.c:954 (parse_cfg): use_first_pass=0
debug: pam_yubico.c:955 (parse_cfg): always_prompt=0
debug: pam_yubico.c:956 (parse_cfg): nullok=0
debug: pam_yubico.c:957 (parse_cfg): ldap_starttls=0
debug: pam_yubico.c:958 (parse_cfg): ldap_bind_as_user=0
debug: pam_yubico.c:959 (parse_cfg): authfile=(null)
debug: pam_yubico.c:960 (parse_cfg): ldapserver=(null)
debug: pam_yubico.c:961 (parse_cfg): ldap_uri=(null)
debug: pam_yubico.c:962 (parse_cfg): ldap_connection_timeout=0
debug: pam_yubico.c:963 (parse_cfg): ldap_bind_user=(null)
debug: pam_yubico.c:964 (parse_cfg): ldap_bind_password=(null)
debug: pam_yubico.c:965 (parse_cfg): ldap_filter=(null)
debug: pam_yubico.c:966 (parse_cfg): ldap_cacertfile=(null)
debug: pam_yubico.c:967 (parse_cfg): ldapdn=(null)
debug: pam_yubico.c:968 (parse_cfg): ldap_clientcertfile=(null)
debug: pam_yubico.c:969 (parse_cfg): ldap_clientkeyfile=(null)
debug: pam_yubico.c:970 (parse_cfg): user_attr=(null)
debug: pam_yubico.c:971 (parse_cfg): yubi_attr=(null)
debug: pam_yubico.c:972 (parse_cfg): yubi_attr_prefix=(null)
debug: pam_yubico.c:973 (parse_cfg): url=(null)
debug: pam_yubico.c:974 (parse_cfg): urllist=(null)
debug: pam_yubico.c:975 (parse_cfg): capath=(null)
debug: pam_yubico.c:976 (parse_cfg): cainfo=(null)
debug: pam_yubico.c:977 (parse_cfg): proxy=(null)
debug: pam_yubico.c:978 (parse_cfg): token_id_length=12
debug: pam_yubico.c:979 (parse_cfg): mode=client
debug: pam_yubico.c:980 (parse_cfg): chalresp_path=(null)
debug: pam_yubico.c:981 (parse_cfg): mysql_server=(null)
debug: pam_yubico.c:982 (parse_cfg): mysql_port=0
debug: pam_yubico.c:983 (parse_cfg): mysql_user=(null)
debug: pam_yubico.c:984 (parse_cfg): mysql_database=(null)
debug: pam_yubico.c:1020 (pam_sm_authenticate): pam_yubico version: 2.28
debug: pam_yubico.c:1035 (pam_sm_authenticate): get user returned: ido
debug: pam_yubico.c:222 (authorize_user_token): Dropping privileges
debug: util.c:351 (check_user_token): Authorization line: ido:***********
debug: util.c:356 (check_user_token): Matched user: ido
debug: util.c:362 (check_user_token): Authorization token: :***********
debug: util.c:362 (check_user_token): Authorization token: (null)
debug: pam_yubico.c:1157 (pam_sm_authenticate): Tokens found for user
YubiKey for `ido':
debug: pam_yubico.c:1220 (pam_sm_authenticate): conv returned 44 bytes
debug: pam_yubico.c:1234 (pam_sm_authenticate): Skipping first 0 bytes. Length is 44, token_id set to 12 and token OTP always 32.
debug: pam_yubico.c:222 (authorize_user_token): Dropping privileges
debug: util.c:351 (check_user_token): Authorization line: ido::***********
debug: util.c:356 (check_user_token): Matched user: ido
debug: util.c:362 (check_user_token): Authorization token: :***********
debug: util.c:366 (check_user_token): Match user/token as ido/:***********
debug: pam_yubico.c:1276 (pam_sm_authenticate): OTP: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ID: :***********
debug: pam_yubico.c:1277 (pam_sm_authenticate): Token is associated to the user. Validating the OTP...
debug: pam_yubico.c:1279 (pam_sm_authenticate): ykclient return value (0): Success
debug: pam_yubico.c:1280 (pam_sm_authenticate): ykclient URL used: https://api.yubico.com/wsapi/2.0/verify?id=00000&nonce=aaaaaaaayxnvkpqixgkufyhbxnyxztvg&otp=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&timestamp=1
debug: pam_yubico.c:1348 (pam_sm_authenticate): done. [Success]
````

Done!

## Screenshots

(1) Translations + JA glyph rendering in fbterm

<img src="./images/en2ja.jpg?raw=true" width="300"/>

## License 

MIT unless specified otherwise

本文记录调教arch中遇到的问题  

# 最终效果    
![](arch调教/Screenshot_01-09-19-14:30:02.png)


## 安装过程中如何连接wifi

### 方法1：    
进入启动盘之后，敲`wifi-menu`，选择要连接wifi，保存配置，输入密码即可。    

### 方法2：
查看无线网卡接口名称: `ip link`    
连接网络： `wpa_supplicant -B -i 网卡名称 -c <(wpa_passphrase wifi名称 wifi密码)`        
注意小于号后不能有空格    

### 安装系统成功后，拔掉U盘，没有wifi，没有连接方法
俺没有装网卡连接的工具，又重新来了一遍。    
重新用启用U盘加载， 挂载之前的分区    
`mount /dev/sda2 /mnt`    
`mount /dev/sda1 /mnt/boot/efi`    

先连上wifi再说， 推荐使用wifi-menu    
切换到已经安装好的系统： `arch-chroot /mnt`    
安装dialog，这样下次开机就能使用wifi-menu了    
`pacman -S networkmanager dialog`    
`pacman -S net-tools`    


然后进去之后wifi-menu连接，又炸了，看报错信息`journalctl -xe`说我已经连接    

接着我就把网卡给关了 `ip link set wlp2s0 down`    
然后按之前wifi配置文件重新连接就ok了！！！    
`netctl start /etc/netctl/wlp2s0-xxxx`    
ping一下，终于ok了！！！

下次重启后在连接，就用`netctl start /etc/netctl/xxx-xxx`就可以了！！！    

## 配置DNS    
如果不配置DNS的话，ping域名的时候，还有打开网站的时候，会有明显的卡顿感，ping ip则不会，这是DNS解析慢导致的。    
编辑`/etc/resolv.conf`    
添加一行 `nameserver 114.114.114.114`    
上面的方法是临时修改的，下次重启还会变回来，要想永久修改，更改`/etc/systemd/resolved.conf`    


## 安装sudo    
安装sudo，配置文件在/etc/sudoers，对其进行配置    
`useradd -m -G wheel 用户名`    
`passwd 用户名` 改指定用户密码    
`passwd` 改root用户密码    
没权限保存的话，可用`:wq!`试试        

## 安装openssh    
`pacman -S openssh`    
`systemctl status sshd`    
`systemctl start sshd`    
`systemctl enable sshd`    

## 安装图形界面    
### 安装xorg    
`sudo pacman -S xorg`    
### 安装xorg-xinit    
`sudo pacman -S xorg-xinit`    
### 配置    
`cp /etc/X11/xinit/xinitrc ~/.xinitrc`    
将后面几行，twm启动和xterm那里删除掉    
![](arch调教/markdown-img-paste-2019082123321298.png)    
删掉图片中内容    

### 安装i3    
`sudo pacman -S i3`    
将启动桌面写入`~/.xinitrc`    
`~/.xinitrc`结尾添加: `exec i3`    
安装字体，否则可能无法正常显示: `sudo pacman -S ttf-font-awesome wqy-bitmapfont wqy-microhei wqy-zenhei nerd-fonts-complete`  我nerd-fonts-complete没找到    

`mod+w`: 切换成折叠式窗口
`mod+e`: 取消折叠式/水平/竖直旋转


### 启动    
`startx`  成功！！！    


## 安装alacritty    
`sudo pacman -S alacritty`    
默认没有终端，可以测试，安装alacritty后，默认终端会变成alacritty    
可设置终端字体大小，在配置文件的`size`，`opacity`是设置透明度，必须有compton支持    
`sudo pacman -S compton`    
将其写入i3配置中    
`exec_always --no-start-ip compton -b`    
更改alacritty的标题栏显示    
在i3的配置中加入一行`new_window pixel 1`    


## 安装dmenu
`sudo pacman -S dmenu`，然后`$mod+d`就有作用了    

## 声音配置    
`cat /etc/group|grep audio`  有一个组，看里面有没有用户。    
`usermod -aG audio 用户名`  给用户添加到audio组.    
安装alsa包    
`sudo pacman -S alsa-utils`    

然后可以用`alsamixer` 查看声卡配置    
标有00的通道已经启用，标有MM的声道是静音的    
按m键接触静音，使用↑增加音量，直到增益值为0    

安装麦克风驱动：    
`sudo pacman -S pulseaudio`    

安装系统托盘图标    
`sudo pacman -S pasystray`    
我没装这个，好像没用    



## 添加源    
在/etc/pacman.conf最后面添加两行    
```bash    
[archlinuxcn]    
Server = https://mirrirs.tuna.tsinghua.edu.cn/archlinuxcn/$arch    
```    
然后`sudo pacman -Sy` 同步源    
然后安装`sudo pacman -S archlinuxcn-keyring`包导入GPG key    

## 安装polybar    
`sudo pacman -S polybar`    
安装polybar的时候，下面会列出一些依赖包，有你已经安装的和未安装的，尽可能装上。    

生成配置文件： `install -Dm644 /usr/share/doc/polybar/config $HOME/.config/polybar/config`    
去查看配置文件： `~/.config/polybar/config`    
编写launch.sh，去看github上的wiki    
```bash
#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar bar1 &
polybar bar2 &

echo "Bars launched..."
```
继续按wifi，删掉i3bar，添加polybar    
pass    

安装字体： `sudo pacman -S noto-fonts noto-fonts-cjk `    
adobe-source-han-sans-cn-fonts    



## 安装输入法
先安装fcitx框架：    
`sudo pacman -S fcitx fictx-im fcitx-configtools`    
安装rime输入法    
`sudo pacman -S fcitx-rime`    
之后重启i3，看看能否在i3bar或polybar中显示托盘图标    

可以的话右键托盘图标`Config Current Input Method`中进行配置，添加rime输入法(台湾)    

在i3的配置文件中添加启动fcitx `exec_always --no-startup-id fcitx`，和polybar配置完全一样    

不需要往.xintrc中添加东西    

然后我就能在chrome中输入中文，在alacritty中输入不了！！！    
解决方法：    
在`/etc/environment`中添加    
```
export GTK_IM_MODULE=fcitx    
export QT_IM_MODULE=fcitx    
export XMODIFIERS=@im=fcitx    
```

默认将rime的繁体中文转换为简体中文：    
`vi ~/.config/fcitx/rime/build/luna_pinyin.schema.yaml`    
在switches配置段的name:simplication下增加一行：`reset:1`    

修改按shift上屏: `vi ~/.config/fcitx/rime/build/default.yml` 修改配置段
```json
ascii_composer/good_old_caps_lock: true
ascii_composer/switch_key:
  Caps_Lock: noop
  Shift_L: commit_code
  Shift_R: inline_ascii
  Control_L: clear
  Control_R: commit_text
```

**一个大坑，把shift切换输入法关掉**
![](arch调教/Screenshot_07-09-19-16:34:58.png)    
![](arch调教/Screenshot_07-09-19-22:05:21.png)    


rime进行输入方案的选择: `ctrl+\`

查看剪切版内容　`ctrl+;`
切换全角和半角: `Shift+Space`
中英文标点切换: `ctrl+.` 这个基本上不会用

## 安装chrome浏览器
pass

## 安装ranger
`sudo pacman -S ranger`    
ranger显示隐藏文件: `zh`    


## 安装图片浏览工具feh
`sudo pacman -S feh`   

## 配置桌面背景图片
在i3的启动文件中进行配置    
`exec_always --no-startup-id feh --bg-scale 图片路径`    

## 配置多显示器
xrandr查看已经连接的显示器.    
`sudo pacman -S arandr` 用图形界面配置显示器布局    
完了可以导出成sh    



## 解决鼠标总是处于忙碌状态
在i3的配置文件中，exec和exec_always后面都加上`--no-startup-id`    




## 安装python和pip，python2对应的pip版本过高
`sudo pacman -S python2 python-pip python2-pip`    
`python2 -m pip install pip==9.0.3`    



## 配置shadowsocks客户端和proxycharins
```
sudo pip install shadowsocks    
sudo ln -s /usr/local/python/bin/sslocal /usr/bin/sslocal    
```
`sudo vi /etc/shadowsocks.conf`   
```json
{
"server":"your_server_ip",
"server_port":"your_server_port",
"local_address":"127.0.0.1",
"local_port":1080,
"password":"your_server_passwd",
"timeout":300,
"method":"aes-256-cfb"
}
```
`sudo sslocal -c /etc/shadowsocks.conf -d start`    

接下来就能通过1080端口出去了     

安装proxychains    
`sudo pacan -S proxychains`   
`vi /etc/proxychains.conf`    
将最后一行改成 `socks5 127.0.0.1:1080`   

接下来就可以使用proxychains了   
`proxychains wget https://www.google.com`   
让整个bash都走代理    
`proxychains bash`    

接下里配置插件SwitchyOmega    
下载该插件和备份的配置文件，将配置文件导入到插件，选自动切换就ok了   


## 安装qq
*`sudo pacman -S deepin.com.qq.im`    
如何报依赖包的问题，将`/etc/pacman.conf`中的multi源取消掉注释，在更新`sudo pamcan -Syyu`，在重装软件*    

配置先pass，要在i3中将其配置成浮动，在设置DPI，在安装依赖包...莫名其妙的好了   

## 安装百度云
`sudo pacman -S baidunetdisk-bin`


## 安装els
> https://github.com/AnthonyDiGirolamo/els

## 安装nvim
pass   

## HHKB键盘DIP开关配置
> https://www.chenshaowen.com/blog/how-to-configure-the-hhkb-keyboard.html    

关掉126，开启345，将i3的Win键改成了Alt
HHKB按`Fn+Q`可进入蓝牙配对模式，也可按电源键三秒进入

## 安装epub阅读器
`sudo pacman -S fbreader`
启动: `FBReader`
使用说明: 和vim类似
```
j,k
f
<C-f>,<C-b>
c,l,i,o,g,Esc
```
可在右键设置里设置颜色，快捷键，字体等等。

### 安装pdf阅读器
`sudo pacman -S foxitreader`
这个很简单

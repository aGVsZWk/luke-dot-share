## jedi-vim
需要python安装`pip3 install jedi`  
我禁用掉了这个插件的自动补全功能，只使用这个插件快捷操作python。  
`<leader>g` 和 `<leader>d`：跳转到定义，只在python中起作用。
`<shift+k>`：查看python帮助文档  
`<leader>r`：重命名  
`<leader>n`：查看所有使用此tag的地方  
`:Pyimport module`：打开module  


## deoplete
需要安装`pip3 install neovim`，neovim中包含依赖插件pynvim等等。

## neosnippet
`<C-K>`或`<Tab>`进行代码片段展开

## ale
安装flake8，autopep8和yamf，其中flake8会依赖pyline  
配置flake8忽略错误内容，更改501长度报错范围参考下图，将配置文件放在项目根目录中！！！  
>> todo 上图      
`tf`: 自动格式化代码


## Leaderf
模糊搜索: 先安装`sudo pacman -S ripgrep`，然后vim中`:Leaderf rg`，然后输入要搜索的内容，已经设置成了快捷键 `<Leader>s`，现在和jedi的快捷键冲突

如果要设置忽略文件，在项目目录的.ignore中设置，语法和git一样，它也自动过滤的.gitignore中的名单。


函数搜索：  `<Leader>p`   `Leaderf function`
文件搜索: `<C-p>`  `:Leaderf file`
搜索好了之后按`<Tab>`切换窗口，按F1查看帮助，再次按Tab可切回搜索框    
行内搜索： `<Leader>l`  `:Leaderf line`
tag搜索: `<leader>w`  `:Leaderf tag`



## nerdcomment
`<Space>cc`: 注释代码
`<Space>cu`: 取消代码
`<Space>ca`: 切换注释风格
`<Space>c<Space>`: 注释/取消注释

## nerdtree
`q` 退出nerdtree窗口  

### 操作文件
`o`: 打开文件并跳转  
`go`: 打开文件不跳转  
`t`: tab窗口打开文件并且跳转，由于有冲突，我一般敲`tg`  
`T`: tab窗口打开不跳转  
`i`: 分割打开  
`gi`: 分割打开不跳转  
`s`: 同i  
`gs`: 同gi  


### 操作目录
`o` 展开/关闭目录    
`O` 递归展开目录   
`x` 关闭目录  
`X` 递归关闭目录  
`t` 用tab形式打开新的nerdtree，并且切换到那个目录。由于和tt冲突会等待，所以我一般敲`tg`  
`T` 用tab形式在后台打开新的窗口。  
`e` 新窗口打开选中目录，用来编辑的  

### 跳转命令
`P`: 跳到根目录  
`p`: 跳到父目录  
`J`: 跳到同级第一个目录  
`K`: 跳到同级最后一个目录  
`<C-J>`和`<C-K>`: 只在同级之间移动  

### 文件系统操作
`C`: 切换文件根目录  
`U`: 切换上级目录作为根目录，保持当前目录的展开状态:q  
`u`: 切换上级目录作为根目录，折叠当前目录  
`r`: 刷新当前文件夹  
`R`: 刷新整个根目录  
`cd`和`CD`: 切换什么CWD，已经取消这个映射了
`m`': 展示菜单，这个相当**有用**，和vim-signature冲突，更改为`M`

### 文件过滤
`I` 查看/关闭隐藏文件  
`B` 查看书签  
`F`: 文件显示/隐藏  

### 其它
`A` 最大化窗口

## vim-signature
标记a-z只能标记单行，标记0-9可以标记多行


`m[a-zA-Z]`  打标签
`'[a-zA-Z]`   跳转到标签位置

`'.`        最后一次变更的地方
`''`        跳回来的地方(最近两个位置跳转)
`m.`：取消/添加标记a-z(不能冲突，只能添加一处)
`m `：删除所有a-z标记
`m0-m9`: 添加0-9标记
`m<BS>`: 删除所有0-9标记


## emmet语法
1.<ctrl-y>,    Expand abbreviation
`div>p#foo$*3>a`
在a后面按`<ctrl-y>,`然后被展开成
"""html
<div>
    <p id="foo1">
    <a href=""></a>
    </p>
    <p id="foo2">
    <a href=""></a>
    </p>
    <p id="foo3">
    <a href=""></a>
    </p>
</div>
"""

2. <ctrl-y>;  Expand word
`<html>foo`
在foo后按`<ctrl-y>;`然后被展开成
```html
<html><foo></foo>
```

3. <ctrl-y>u   Update tag
起始代码是`<div>foo</div>`
在起始div左边的小于号按`<ctrl-y>u`
然后弹出窗口，输出`.global` 回车
代码就会变成`<div class="global">foo</div>`

4. <ctrl-y>,   Wrap with abbreviation
起始代码:
```
test1
test2
test3
```
选中上面三行，按`<ctrl-y>,`弹出窗口，输入
`ul>li*`回车
之后的代码:
```html
  <ul>
      <li>test1</li>
      <li>test2</li>
      <li>test3</li>
  </ul>
```
你也可以选中后输入blockquote，然后就会在外面添加该元素




。

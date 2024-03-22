# fcitx5-switcher.nvim
## what is it
一个 neovim 插件，在特定条件下自动将 Fcitx5 输入法更改为中文输入法。
- 功能1：当光标前的字符为中文字符（Unicode 4E00-9FFF）时，此时进入 insert mod 时，将自动切换为中文输入法。
- 功能2：按下一个可以配置的按键，进入 insert mod 并自动切换为中文输入法。
## Installation
使用[lazy.nvim](https://github.com/folke/lazy.nvim)
~~~lua
require("lazy").setup({
  "puddings233/fcitx5-switcher.nvim",
  config = function()
    require("fcitx5-switcher-custom").setup({
      enable_manual = false,
      key = "nil",
      mod = "nil"
    })
  end
})
~~~
## Configuration
通过修改安装选项，可以进行对功能2的自定义。
~~~lua
require("fcitx5-switcher-custom").setup({
  --- 是否启用功能2，可接受 "true", "false"
  enable_manual = false,
  --- 启用功能2的按键
  key = "nil",
  --- insert mod 的进入方式，可接受 "i", "a"
  mod = "nil"
})
~~~
## Inspiration
[Video](https://www.bilibili.com/video/BV1U94y1e7HS)

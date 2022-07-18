# 我的 vim 备份设置

# 一. 当换了一台新机器我该如何做?
1.1 从 github 拉取自己的 git 仓库
```bash
cd ~/.vim
git clone --recursive git@github.com:{your_github_name}/{your_repostoy_name}.git
```
1.2 升级所有插件
```bash
git submodule update --recursive --remote
```

# 二. 我该如何备份 .vim 文件？？ 
> 利用 git submodule 命令来下载插件，从而构建一个 git 仓库，以此便可实现备份

2.1 把~/.vim做成一个git仓库，然后初始化submodule
```bash
cd ~/.vim
git init
git submodule init
```

2.2 添加第三方插件，比如ale
```bash
cd ~/.vim
git submoudle add git@github.com:dense-analysis/ale.git pack/mypackage/start/ale
```

**注意:** 如果1，2 没有解决问题，请详细阅读: 
```bash
https://blog.hulifa.cn/2019-10-20-Vim-8%E5%86%85%E7%BD%AE%E5%8C%85%E7%AE%A1%E7%90%86%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/
```

# 三. exception
> 有些插件依赖于特定机器平台，需要二次安装

## 3.1 leaderf 
 请额外安装 ctags 与 rg, 否则 leader funciton 不会正常工作
## 3.2 ycm
 需要额外几步
 1. 安装支持 python3 的 vim， 通过 vim --version | grep python 来查看是否支持
 2. 进入 ycm 官方页面进行安装教程
 3. 在 .vimrc 中配置代码
 详情阅读:
 *https://github.com/ycm-core/YouCompleteMe*

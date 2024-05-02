# piaoxingqiu

使用flutter开发的模拟票星球的跨平台app

目前仍在早期开发阶段，功能有限。

## 功能列表
- [x] 登录
- [x] 演唱会列表
- [x] 演唱会详情
- [ ] 预下单
- [ ] 添加收获地址
- [ ] 添加观影人
- [ ] 个人信息
- [ ] 余票通知


## 启动
由于目前仍在开发中，仅提供开发模型下的启动方法

### 环境安装
1. 安装好flutter环境，vscode
2. vscode安装flutter插件

### windows模式启动

vscode直接启动windows模式

### web模式启动
1. 安装nginx
2. 将`deployment/nginx/flutter_nginx.conf`中的配置添加到nginx中
3. vscode启动web模式
4. 浏览器打开http://localhost
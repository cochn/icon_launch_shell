# icon_launch_shell
生成,修改项目AppIcon和launcImage的脚本

## 下载之后执行 chmod +x set_icon_launch.sh

## 生成AppIcon
./set_icon_launch.sh -n -i [AppIcon图片绝对路径]

## 修改现有项目的AppIcon
./set_icon_launch.sh -p [项目根路径] -i [AppIcon图片绝对路径]

## 修改现有项目的launcImage
./set_icon_launch.sh -p [项目根路径] -l [launcImage图片绝对路径]

## 修改Assets.xcassets里指定 *.imageset图片
./set_icon_launch.sh -p [项目根路径] -i [AppIcon图片绝对路径] -c []imageset名称]

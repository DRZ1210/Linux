## shell 基本知识

#### 一 console、Terminal、shell三者之间的区别

​		这还要从之前的大型主机，用多任务多用户的那种说起。学习机电的同学应该知道，对于一个机床，会有一个布满控制开关的台面，可以操作台面上的开关控制机床的运行。同样，计算机也存在这样的一个控制台，用于控制计算机运行，这就是console（控制台）。

​		Terminal（终端），对于多用户多任务的计算机，会连出很多个终端，这个终端包含键盘和显示器，通过串口和电线和电脑主机相连。它可以接受用户输入的数据，同时将输入的数据在屏幕上显示出来。

​		shell，什么是shell？它是一个命令行解释机，是人机交互的接口。GUI（graphic user interface）本质上就是一个shell。shell分为不同的种类，比较常见的: bash、zsh、ash、sh 等等。

![image-20200320155254590](/home/dengruizhi/.config/Typora/typora-user-images/image-20200320155254590.png)

![img](https://pic2.zhimg.com/80/419d4cef5c7f9269dc7118ea2ac408b8_720w.jpg)

---

#### 二 关于shell的基本知识

我们以bash为例，关于bash的配置，存在全局配置和个人配置 

（system-wide Config and Setup、individual Config and Setup）

关于全局配置涉及到的几个重要的文件：/etc/bash.bashrc、/etc/bash.profile、/etc/bash.bash.logout

个人配置涉及到的文件，在用户的家目录下面：.bashrc、.bash_profile、.bash_logout、.input



bash_profile文件，当用户登陆时会被读取，其中包含的命令会被bash运行，可以把它理解为类的构造函数

bashrc （bash resource 资源文件）可以理解为bash_profile的替补，可以保存用户的个性化配置，比如用户自定义的命令别名等等。当bash_profile文件被执行时，bashrc文件也会被执行。

bash_logout顾名思义，当用户退出时，该文件会被读取，所以用户也可以在这里写一些命令，例如删除登陆之后产生的日志文件，临时文件等等。



小编就在自己的远程树梅派对这几个文件进行了操作，当登陆和退出时，可以显示相应的欢迎或者再见，同时显示此次登陆的时间。

---




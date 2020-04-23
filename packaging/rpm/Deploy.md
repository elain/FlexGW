Flex GateWay Deploy
===================

环境要求
-------

OS: Centos 7.x

注：请以root 身份执行下面步骤的命令。

设置系统环境
----------

编辑/etc/sysctl.conf 文件：

1. Disable redirects.

    `sysctl -a | egrep "ipv4.*(accept|send)_redirects" | awk -F "=" '{print $1"= 0"}'`

    请编辑sysctl.conf 文件，将上面配置的值均设为0。配置文件里没有的，请添加上。

2. enable ip forward.

    net.ipv4.ip_forward = 1

    请编辑sysctl.conf 文件，将该配置的值设置为1。

3.  执行命令`sysctl -p`

安装依赖的软件包
--------------

以root 身份执行：

1. yum install -y git strongswan openvpn zip curl wget 

如需要自己编译安装以下依赖包:

1. yum -y rpm-build python-pip zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel \
openssl-devel xz xz-devel libffi-devel gcc gcc-c++ -y

安装flexgw rpm 包
----------------

1. rpm -ivh rpms/flexgw-2.0.0-1.el7.centos.x86_64.rpm


初始化配置
---------
1. 初始化strongswan 配置文件：

    cp -fv /usr/local/flexgw/rc/strongswan.conf /etc/strongswan/strongswan.conf

2. 初始化openvpn 配置文件：

    cp -fv /usr/local/flexgw/rc/openvpn.conf /etc/openvpn/server/server.conf

设置strongswan
--------------

1. 将/etc/strongswan/strongswan.d/charon/dhcp.conf 配置文件：
   注释掉“load = yes” 这行。
   
2. 清空密钥配置文件：

   \> /etc/strongswan/ipsec.secrets


测试运行strongswan
-----------------

1. strongswan start

2. strongswan status

3. strongswan stop

设置flexgw
----------

**如果只是测试的话，请不要执行此步骤。**

1. ln -s /etc/init.d/initflexgw /etc/rc3.d/S98initflexgw
2. 关机。
3. 打快照，制作为镜像。

此步骤做完之后，请不要再次开机，否则会初始化flexgw 配置文件到镜像里。

关于测试
-------

测试的话，请不要执行「设置flexgw」步骤。仅手工执行以下命令：

/etc/init.d/initflexgw (喝杯茶休息下。。。)

大约10秒左右，flexgw 就会自动配置好，并启动。启动完毕之后，访问`https://公网IP` 即可看到登录界面。

**测试完毕，请停止服务，并重装flexgw rpm 包：**

1. /etc/init.d/flexgw stop
2. rpm -e flexgw && rm -rf /usr/local/flexgw
3. rpm -ivh flexgw-1.1.0-1.el7.centos.x86_64.rpm

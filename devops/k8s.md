docker
  root
  守护进程，会导致在多个核心上占用 100% CPU 资源，并导致主机无法正常使用
  使用C/S模型创建容器，跟守护进程通信

podman
  不需要守护进程
  使用用户命名空间，所以是在 ~/.local/containers 中，而不是 /var/lib/docker 中
  alias docker=podman，80%命令都是相同的，是使用 fork/exec 模型来创建容器

buildah
  构建 oci 图像，因为 podman 这块比较慢，还需要大量磁盘空间
  而buildah使用 dockerfile 构建，同样不需要 root 权限

skopeo
  是一个工具，允许我们使用推/拉/复制镜像来处理 docker/oc 镜像

终上所述，就是 buildah 用于构建容器，podman 用于运行容器，而 skopeo 用于传输容器镜像，能够解决docker守护程序导致的启动跟安全问题

/var/log/audit/audit.log
从初始进程 fork 跟 execute 的所有进程都会自动继承 loginuid，如果是 docker，cat /proc/self/loginuid 会发生变化



helm 类似 yum/apt，只是用于管理 k8s 下的 docker

Tiller，helm 的服务端，部署于 k8s 内，接受 helm 的请求

Chart，helm 的软件包，采用 tar 格式

Release， 在k8s集群中运行的一个 chart 实例，

Repository，用于发布跟存储chart的仓库
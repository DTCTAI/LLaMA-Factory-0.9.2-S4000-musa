# 摩尔线程S4000 魔改llamaFactory 适配musa
* 

* llamaFactory开源地址 [查看](https://github.com/hiyouga/LLaMA-Factory)

# 快速启动

* 基础系统镜像

~~~
Ubuntu 22.04.x LTS x86_64, Kernel version 5.15.0-105-generic
~~~

* musa驱动安装
  [查看细节](https://mcconline.mthreads.com/repo/musa-pytorch-release-public?repoName=musa-pytorch-release-public&repoNamespace=mcconline&displayName=Pytorch%20on%20MUSA%20Release)

* 拉取docker镜像

~~~
   docker pull musa-pytorch-dev-public:rc3.1.0-v1.3.0-S4000-py310
~~~

* 下载源码

~~~
cd /data
git clone xxxx
~~~

* 构建镜像

~~~
cd /data/LLaMA-Factory-0.9.2-S4000-musa/docker/docker-musa
docker build -t musa_s4000_llama_factory:0.1 .
~~~

* 启动容器

~~~
docker-compose up -d
~~~

* 安装llamaFactory并且启动webui

~~~
docker exec -it [容器id] bash
cd /data/LLaMA-Factory-0.9.2-S4000-musa
pip install -e ".[torch,metrics]"
llamafactory-cli webui
~~~

* 通过服务器7860端口即可访问服务

~~~
http://server_ip:7860
~~~

# 具体的魔改适配内容

## 源码修改

* 修改 src/llamafactory/extras/misc.py

~~~
增加musa条件分支:
 
is_torch_musa_available
~~~

* 对所有符合条件的py文件进行修改

~~~
在import torch 后添加 import torch_musa
~~~

* 依赖修改

~~~
1. 更新transformers
   pip install --upgrade transformers

2. 更新pydantic==2.10.6
   pip install pydantic==2.10.6
~~~

## 其他

### 模型下载相关

* 默认是huggingface，会被墙，通过环境变量可以配置modelscope下载

~~~
USE_MODELSCOPE_HUB=1
MODELSCOPE_CACHE=/data/LLaMA-Factory-0.9.2-S4000-musa/Models
~~~

* 考虑到有些服务器存在限速问题，解决方法：

~~~
1. 先找到模型缓存路径
2. 从modelscope上手动下载模型
3. 本地模型传输至服务器的模型缓存目录
~~~

### 解决容器内部的显存报错问题

* 环境变量设置：

~~~
MTHREADS_VISIBLE_DEVICES=1
~~~

## 容器内部启动

* 安装llamaFactory

~~~
docker exec -it [容器id] bash
cd /data/LLaMA-Factory-0.9.2-S4000-musa
pip install -e ".[torch,metrics]"
~~~

* 容器内部运行webui

~~~
llamafactory-cli webui
~~~

## 针对个别模型的适配

### QWen2.5_3B

* 报错日志

~~~
RuntimeError: Now torch_musa only allows explicit value of `scale` parameter, whose value is equal to `1/sqrt(query.size(-1))`.
~~~

* 修改容器内部源码第53行
* /opt/conda/envs/py310/lib/python3.10/site-packages/transformers/integrations/sdpa_attention.py

~~~
scale = 1.0 / (query.size(-1) ** 0.5)  # 手动计算 scale
attn_output = F.scaled_dot_product_attention(
    query, key, value,
    attn_mask=attn_mask,
    dropout_p=dropout_p,
    is_causal=is_causal,
    scale=scale,  # 显式传入 scale
)
return attn_output
~~~

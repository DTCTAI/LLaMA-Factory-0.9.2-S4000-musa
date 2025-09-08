# 🚀 LLaMA-Factory-S4000-MUSA

<p align="center">
  <img src="./assets/dtct.png" alt="浙江德塔森特总部研发中心" width="200"/>
</p>

<p align="center">
  <em>浙江德塔森特总部研发中心</em>
</p>

<p align="center">
  <a href="./LICENSE"><img src="https://img.shields.io/github/license/xxxx/LLaMA-Factory-S4000-MUSA" alt="License"/></a>
  <img src="https://img.shields.io/badge/python-3.10%2B-blue" alt="Python"/>
  <img src="https://img.shields.io/badge/torch-musa-green" alt="Torch"/>
  <img src="https://img.shields.io/badge/docker-ready-blue" alt="Docker"/>
</p>

> 基于 [LLaMA-Factory0.9.2](https://github.com/hiyouga/LLaMA-Factory) 的魔改版本，适配 **摩尔线程 S4000 GPU (MUSA 架构)**，支持大语言模型的训练、微调与推理，并提供 WebUI 交互界面。

---

## ✨ 特性

- 🔧 **MUSA 适配**：支持 `torch_musa`，可直接运行在摩尔线程 S4000 上  
- 🐳 **Docker 一键部署**：提供官方镜像与构建脚本，环境可快速启动  
- 🌐 **国内源模型下载**：已切换为 Modelscope 通道  
- ⚡ **性能优化**：显存环境变量配置、源码兼容性补丁  
- 🧩 **模型适配**：已测试并修复 **Qwen2.5-3B** 等模型


## 📦 快速开始

### 1️⃣ 环境要求
- Ubuntu 22.04.x LTS x86_64  
- Kernel == 5.15.0  
- 摩尔线程 S4000 GPU  
- Docker / Docker Compose  

---

### 2️⃣ 安装 MUSA 驱动
👉 [官方文档参考](https://mcconline.mthreads.com/repo/musa-pytorch-release-public?repoName=musa-pytorch-release-public&repoNamespace=mcconline&displayName=Pytorch%20on%20MUSA%20Release)

---

### 3️⃣ 拉取镜像
```bash
docker pull musa-pytorch-dev-public:rc3.1.0-v1.3.0-S4000-py310
```

---

### 4️⃣ 下载源码
```bash
cd /data
git clone https://github.com/DTCTAI/LLaMA-Factory-0.9.2-S4000-musa.git
```

---

### 5️⃣ 构建镜像
```bash
cd /data/LLaMA-Factory-0.9.2-S4000-musa/docker/docker-musa
docker build -t musa_s4000_llama_factory:0.1 .
```

---

### 6️⃣ 启动服务
```bash
docker-compose up -d
```

---

### 7️⃣ 进入容器 & 启动 WebUI
```bash
docker exec -it [容器id] bash
cd /data/LLaMA-Factory-0.9.2-S4000-musa
pip install -e ".[torch,metrics]"
llamafactory-cli webui
```

访问地址：  
👉 `http://server_ip:7860`
---

## 🔧 魔改说明

### ✅ 源码修改
- `src/llamafactory/extras/misc.py`  
  新增 `is_torch_musa_available` 分支
- 
- 所有的py文件根据条件增加：
  ```如果存在 import torch, 则在其后增加：
  import torch_musa
  ```

---

### ✅ 依赖更新
```bash
pip install --upgrade transformers
pip install pydantic==2.10.6
```

---

### ✅ 模型下载优化
支持 **Modelscope**，避免网络受限：
```bash
export USE_MODELSCOPE_HUB=1
export MODELSCOPE_CACHE=/data/LLaMA-Factory-0.9.2-S4000-musa/Models
```

---

### ✅ 显存报错修复
容器内设置：
```bash
export MTHREADS_VISIBLE_DEVICES=1
```

---

### ✅ 特殊模型适配（QWen2.5_3B）
修改 `transformers/integrations/sdpa_attention.py` 第 53 行：  
```python
scale = 1.0 / (query.size(-1) ** 0.5)
attn_output = F.scaled_dot_product_attention(
    query, key, value,
    attn_mask=attn_mask,
    dropout_p=dropout_p,
    is_causal=is_causal,
    scale=scale,
)
```

---

## 📌 项目目标
- 推动 **国产 GPU** 在大模型领域的应用落地  
- 打通 **LLaMA-Factory** 与 **MUSA 生态** 的兼容性  
- 为科研与企业提供 **低成本的国产算力替代方案**  

---

## 📊 项目结构
```
LLaMA-Factory-0.9.2-S4000-musa
├── docker/                # Docker 构建与运行配置
├── src/llamafactory/      # 源码修改位置
├── models/                # 模型存放目录
└── README.md              # 项目说明文档
```

---

## 🤝 贡献
欢迎提交 PR 或 issue，一起完善适配与优化！  

---

## 📜 License
本项目基于 [Apache 2.0 License](./LICENSE) 开源。  
原项目版权归 [LLaMA-Factory](https://github.com/hiyouga/LLaMA-Factory) 所有。  

## 联系方式
- 公司官网: [https://www.dtctcn.com/](https://www.dtctcn.com/)
- 产品服务电话: 400-865-5169
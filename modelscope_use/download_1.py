from modelscope import snapshot_download
model_dir = snapshot_download(
    "ZhipuAI/chatglm3-6b",
    revision="master",
    cache_dir=r"C:\Users\10787\Desktop\LLM\LLaMA-Factory-0.9.2\Models",
    # resume_download=True  # 启用断点续传
)

'''
linux cache_dir
/root/.cache/huggingface/hub/models--THUDM--chatglm3-6b/snapshots/e9e0406d062cdb887444fe5bd546833920abd4ac/
'''
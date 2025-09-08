FROM musa-pytorch-dev-public:rc3.1.0-v1.3.0-S4000-py310
LABEL authors="zhangzibao"

ADD ./requirements.txt /home/
RUN pip install -r /home/requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
CMD echo "------python3.10 for llama_musa-----"
CMD /bin/bash
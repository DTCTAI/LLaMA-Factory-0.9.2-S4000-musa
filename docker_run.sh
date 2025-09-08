sudo docker run -it --rm -p 7860  -v /home/mccxadmin/testFire/LLMProjects/LLaMA-Factory-0.9.2:/root/LLaMA-Factory-0.9.2 --privileged --env MTHREADS_VISIBLE_DEVICES=ALL s4000_llama_factory:0.2 /bin/bash

sudo docker run -it -p 7860  -v /home/mccxadmin/testFire/LLMProjects/LLaMA-Factory-0.9.2:/root/llamaFctoryTest --privileged --env MTHREADS_VISIBLE_DEVICES=ALL s4000_llama_factory:0.2 /bin/bash

sudo docker run -it --rm --privileged --env MTHREADS_VISIBLE_DEVICES=1 registry.mthreads.com/mcconline/musa-pytorch-dev-public:rc3.1.0-v1.3.0-S4000-py310 /bin/bash

sudo docker run -it -p 7860  -v /home/mccxadmin/testFire/LLMProjects/LLaMA-Factory-0.9.2:/root/llamaFctoryTest --privileged --env MTHREADS_VISIBLE_DEVICES=1 s4000_llama_factory:0.2 /bin/bash

sudo docker run --rm  -it -p7860 --privileged --env MTHREADS_VISIBLE_DEVICES=1 227df1d14e39 /bin/bash




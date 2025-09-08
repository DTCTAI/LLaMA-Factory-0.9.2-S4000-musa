cd /data/ai-project-deploy/platform
docker-compose -f docker-compose.yaml up -d

cd /data/ai-project-deploy/dify
docker-compose -f  docker-compose.yaml up -d

cd /data/ai-project-deploy/xinference
docker-compose -f docker-compose-xinference.yaml up -d

cd /data/ai-project-deploy/ppocr
docker-compose -f docker-compose-ppocr.yaml up -d


# App

```bash
uv venv --python 3.12
uv sync
```

```bash
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 979559056307.dkr.ecr.ap-southeast-1.amazonaws.com

docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder

docker buildx build --platform linux/arm64,linux/amd64 -t 979559056307.dkr.ecr.ap-southeast-1.amazonaws.com/aldred/demo-devops-app:v0 --push .

# docker build --platform linux/amd64 -t 979559056307.dkr.ecr.ap-southeast-1.amazonaws.com/aldred/demo-devops-app:v0:v0 .
# docker push 979559056307.dkr.ecr.ap-southeast-1.amazonaws.com/aldred/demo-devops-app:v0
```

Run locally

```bash
docker pull 79559056307.dkr.ecr.ap-southeast-1.amazonaws.com/aldred/demo-devops-app:v0
docker run -p 18080:18080 979559056307.dkr.ecr.ap-southeast-1.amazonaws.com/aldred/demo-devops-app:v0
```

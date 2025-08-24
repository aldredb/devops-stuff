# Simple Flask API

Setup

```bash
uv venv --python 3.12
source .venv/bin/activate
uv sync
```

Test

```bash
uv run python -m pytest
```

```bash
export CR_PAT=YOUR_TOKEN
echo $CR_PAT | docker login ghcr.io -u aldredb --password-stdin
```

```bash
docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder

docker buildx build --platform linux/arm64,linux/amd64 -t ghcr.io/aldredb/devops-stuff:v0 --push .

docker buildx build --load -t ghcr.io/aldredb/devops-stuff:v0 .

# docker build -t ghcr.io/aldredb/devops-stuff:manual-v1 .
# docker push ghcr.io/aldredb/devops-stuff:manual-v1
```

Run locally

```bash
docker pull ghcr.io/aldredb/devops-stuff:v0
docker run -p 18080:18080 ghcr.io/aldredb/devops-stuff:v0
```

```bash
git tag -a v1.0.0 007e942 -m 'First release'
git push origin v1.0.0 
```

```bash
trivy image --format sarif --output result.sarif --severity MEDIUM,HIGH ghcr.io/aldredb/devops-stuff:v0
```

Manual manifest

```bash
docker buildx build --platform linux/arm64 -t ghcr.io/aldredb/devops-stuff:manual-v0-arm64 --load .
docker buildx build --platform linux/amd64 -t ghcr.io/aldredb/devops-stuff:manual-v0-amd64 --load .

docker push ghcr.io/aldredb/devops-stuff:manual-v0-arm64
docker push ghcr.io/aldredb/devops-stuff:manual-v0-amd64

docker manifest create ghcr.io/aldredb/devops-stuff:manual-v0 ghcr.io/aldredb/devops-stuff:manual-v0-arm64 ghcr.io/aldredb/devops-stuff:manual-v0-amd64

docker manifest annotate ghcr.io/aldredb/devops-stuff:manual-v0 ghcr.io/aldredb/devops-stuff:manual-v0-amd64 --os linux --arch amd64
docker manifest annotate ghcr.io/aldredb/devops-stuff:manual-v0 ghcr.io/aldredb/devops-stuff:manual-v0-arm64 --os linux --arch arm64

docker manifest push ghcr.io/aldredb/devops-stuff:manual-v0
```

Quay

```bash
docker login -u='aldredb' -p='<Password>' quay.io
docker buildx build --platform linux/arm64,linux/amd64 -t quay.io/aldredb/devops-stuff:v0 --push .
```

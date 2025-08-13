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
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
```

```bash
docker buildx create --use --platform=linux/arm64,linux/amd64 --name multi-platform-builder

docker buildx build --platform linux/arm64,linux/amd64 -t ghcr.io/aldredb/devops-stuff:v0 --push .

# docker build --platform linux/amd64 -t ghcr.io/aldredb/devops-stuff:v0 .
# docker push ghcr.io/aldredb/devops-stuff:v0
```

Run locally

```bash
docker pull ghcr.io/aldredb/devops-stuff:v0
docker run -p 18080:18080 ghcr.io/aldredb/devops-stuff:v0
```

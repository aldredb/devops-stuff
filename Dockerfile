FROM python:3.12-slim AS base

# FROM base AS builder
COPY --from=ghcr.io/astral-sh/uv:0.8.9 /uv /bin/uv

ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

WORKDIR /app

# Can be further optimized
COPY . /app

RUN uv sync --frozen --no-dev 

# FROM base
# COPY --from=builder /app /app

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 18080

CMD ["gunicorn", "--bind", "0.0.0.0:18080", "main:app"]
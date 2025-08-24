FROM python:3.12-slim AS builder

COPY --from=ghcr.io/astral-sh/uv:0.8.9 /uv /bin/uv

ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

WORKDIR /app

COPY pyproject.toml uv.lock /app

# Install dependencies
RUN uv sync --frozen --no-dev 

FROM python:3.12-slim

WORKDIR /app

COPY . .

COPY --from=builder /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 18080

CMD ["gunicorn", "--bind", "0.0.0.0:18080", "main:app"]
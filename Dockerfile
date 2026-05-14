FROM --platform=linux/amd64 ghcr.io/astral-sh/uv:python3.12-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/venv \
    UV_PROJECT=/src/bopen/edh-catalogue-deploy

COPY edh-catalogue-api /src/bopen/edh-catalogue-api
COPY edh-catalogue-manager /src/bopen/edh-catalogue-manager
COPY edh-catalogue-deploy /src/bopen/edh-catalogue-deploy

WORKDIR /src/bopen/edh-catalogue-deploy

RUN uv sync --frozen --all-extras

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "--host", "0.0.0.0", "--port", "8000", "edh_catalogue_api.app:app"]

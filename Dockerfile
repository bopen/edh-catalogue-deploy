FROM --platform=linux/amd64 ghcr.io/astral-sh/uv:python3.12-bookworm-slim
ARG GIT_PAT

ENV DEBIAN_FRONTEND=noninteractive

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/venv \
    UV_PROJECT=/src/bopen/edh-catalogue-deploy

WORKDIR /src

# install git-clone-ref.py dependencies
RUN apt update && apt install -y git \
    && apt clean

# get git-clone-ref.py script
COPY ./git-clone-ref.py /tmp/git-clone-ref.py

COPY edh-catalogue-api /src/bopen/edh-catalogue-api
COPY edh-catalogue-manager /src/bopen/edh-catalogue-manager
COPY edh-catalogue-deploy /src/bopen/edh-catalogue-deploy

# Download all dependencies into the uv cache.
# but delete the virtual environment to save space, it will be re-created during uv run.
RUN uv sync --frozen --all-extras \
    && rm -rf /venv

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "--host", "0.0.0.0", "--port", "8000", "edh_catalogue_api.app:app"]

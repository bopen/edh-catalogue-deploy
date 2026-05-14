# EDH Catalogue Deployment

This repository is a dedicated deployment environment for the EDH Catalogue system. It does not contain source code of its own. Instead, it utilizes a [uv virtual workspace](https://docs.astral.sh/uv/concepts/workspaces/) to seamlessly resolve dependencies and bundle two sibling repositories into a single Docker image:

* `edh-catalogue-api`
* `edh-catalogue-manager`

## Required Folder Structure

Because this project relies on a local workspace, the repositories **must** be cloned side-by-side in the same parent directory before running `uv` or building the Docker image.

```text
your-working-directory/
├── edh-catalogue-api/        # Sibling repository
├── edh-catalogue-manager/    # Sibling repository
└── edh-catalogue-deploy/     # This repository

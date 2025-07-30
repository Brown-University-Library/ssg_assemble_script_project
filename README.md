# Fashioning Insurrection Build Script

This script automates -- for Library staff -- a build of the Fashioning Insurrection static website. It handles updating the build repository and syncing assets from a remote server to the local build directory.

The purpose of building this way is to be able to have the core of the static-site take advantage of github's versioning, without the churn and unnecessary bloat of including changing binary images.

A proprietary font is used, so the font files are stored on a remote server and synced to the local build directory.


## Prerequisites

- `bash` shell
- `git`
- `rsync`
- A properly configured `fi_build_dotenv.sh` file in the parent directory


## Configuration

Before running the script, ensure you have a `fi_build_dotenv.sh` file in the parent directory with the following environment variables set:

```bash
# Remote server configuration
export FI_BUILD__REMOTE_SERVER="user@example.com"
export FI_BUILD__REMOTE_IMAGE_DIR="/path/to/remote/images"
export FI_BUILD__REMOTE_FONT_DIR="/path/to/remote/fonts"
```

## Assumed Directory Structure

```
fi_build_stuff/
├── fi_build_script/
│   └── fi_build_script.sh
├── fi_build_dotenv.sh
└── fashioning_insurrection_site_build/
    ├── img/
    └── fonts/
```

## Usage

```bash
bash ./fi_build_script.sh
```

## What the Script Does

1. Verifies the working directory
2. Sources environment variables from `fi_build_dotenv.sh`
3. Sets up directory paths
4. Updates the local build repository by pulling the latest changes
5. Syncs images and fonts to the remote server using rsync


## Error Handling

The script includes error handling to:
- Verify directory existence and accessibility
- Confirm successful sourcing of environment variables
- Check git operations
- Validate rsync operations


## Notes

- The script uses `rsync` with the `--delete` flag, which will remove files on the remote that don't exist locally
- Ensure you have proper SSH access to the remote server
- The script is designed to be run from its own directory and will alert you if it is not run from the correct directory

---

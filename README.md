# Static-Site Generator (SSG) Assemble Script

This script automates -- for Library staff -- a build of the specified static website. It's designed for a specific purpose: to _assemble_ a static-site directory from two sources:

- a github repository containing everything but the image and font assets

- the remote image and font directories

The script updates the local SSG repository directory, then rsyncs assets from a remote server to the local SSG directory.

The purpose of building this way is to be able to have the core of the static-site take advantage of github's versioning, without the churn and unnecessary bloat of including changing binary images.

A proprietary font is used, so the font files are stored on a remote server and synced to the local build directory.


## Prerequisites

- `bash` shell
- `git`
- `rsync`
- having git cloned the SSG repository
- likely VPN
- A properly configured `ssg_assemble_dotenv.sh` file in the parent directory


## Configuration

Before running the script, ensure you have a `fi_build_dotenv.sh` file in the parent directory with the following environment variables set:

```bash
# Remote server configuration
export SSG_ASSEMBLE__REMOTE_SERVER="user@example.com"
export SSG_ASSEMBLE__REMOTE_IMAGE_DIR="/path/to/remote/images"
export SSG_ASSEMBLE__REMOTE_FONT_DIR="/path/to/remote/fonts"
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


## TODO
- remove more references to the `fashioning insurrection` project, so the code is more generic

---

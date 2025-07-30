## build-script for assembling the stand-alone, non-server FI static-site
echo " "
echo ":: starting fi_build_script.sh"
echo " "

## confirm we're in the correct `fi_build_script` directory ---------
script_dir="$(realpath "$(dirname "$0")")" || { echo "Error: Failed to get realpath of directory $(dirname "$0")" >&2; exit 1; }
cd "$script_dir" || { echo "Error: Failed to change to directory $script_dir" >&2; exit 1; }
echo ":: confirmed we're staring from the correct directory: $script_dir"
echo " "

## source the dotenv file -------------------------------------------
dotenv_path="$(realpath "../fi_build_dotenv.sh")" || { echo "Error: Failed to get realpath of fi_build_dotenv.sh" >&2; exit 1; }
source "$dotenv_path" || { echo "Error: Failed to source $dotenv_path" >&2; exit 1; }
echo ":: envars sourced from: $dotenv_path"
echo " "

## set vars ---------------------------------------------------------
LOCAL_BUILD_DIR="$(realpath "../fashioning_insurrection_site_build")" || { echo "Error: Build directory not found at $(cd .. && pwd)/fashioning_insurrection_site_build" >&2; exit 1; }
LOCAL_IMAGE_DIR="$(realpath "../fashioning_insurrection_site_build/img")" || { echo "Error: Image directory not found at $(cd .. && pwd)/fashioning_insurrection_site_build/img" >&2; exit 1; }
# LOCAL_FONT_DIR="$(realpath "../fashioning_insurrection_site_build/fonts")" || { echo "Error: Font directory not found at $(cd .. && pwd)/fashioning_insurrection_site_build/fonts" >&2; exit 1; }
GIT_BUILD_REPO="https://github.com/Brown-University-Library/fashioning_insurrection_site_build.git"
REMOTE_SERVER=$FI_BUILD__REMOTE_SERVER          # from the dotenv-source
REMOTE_IMAGE_DIR=$FI_BUILD__REMOTE_IMAGE_DIR    # from the dotenv-source
# REMOTE_FONT_DIR=$FI_BUILD__REMOTE_FONT_DIR      # from the dotenv-source
echo ":: vars prepared..."
echo "- LOCAL_BUILD_DIR: $LOCAL_BUILD_DIR"
echo "- LOCAL_IMAGE_DIR: $LOCAL_IMAGE_DIR"
echo "- LOCAL_FONT_DIR: $LOCAL_FONT_DIR"
echo "- GIT_BUILD_REPO: $GIT_BUILD_REPO"
echo "- REMOTE_SERVER: $REMOTE_SERVER"
echo "- REMOTE_IMAGE_DIR: $REMOTE_IMAGE_DIR"
# echo "- REMOTE_FONT_DIR: $REMOTE_FONT_DIR"

## update the repo --------------------------------------------------
cd "$LOCAL_BUILD_DIR" || { echo "Error: Failed to change to directory $LOCAL_BUILD_DIR" >&2; exit 1; }
git pull $GIT_BUILD_REPO

## rsync the images and fonts ---------------------------------------
cd "$LOCAL_BUILD_DIR" || { echo "Error: Failed to change to directory $LOCAL_BUILD_DIR" >&2; exit 1; }
rsync -avz --delete "$REMOTE_SERVER:$REMOTE_IMAGE_DIR/" "$LOCAL_IMAGE_DIR"
# rsync -avz --delete "$REMOTE_SERVER:$REMOTE_FONT_DIR/" "$LOCAL_FONT_DIR"

cd "$script_dir" || { echo "Error: Failed to change to directory $script_dir" >&2; exit 1; }
echo ":: fi_build_script.sh completed successfully"

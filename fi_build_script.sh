## asumptions:
## - code is run from the `fi_build_script` directory

## source the dotenv file -------------------------------------------
source ../fi_build_dotenv.sh || { echo "Error: Failed to source fi_build_dotenv.sh" >&2; exit 1; }

## set vars
LOCAL_BUILD_DIR="$(realpath "../fashioning_insurrection_site_build")"
LOCAL_IMAGE_DIR="$(realpath "../fashioning_insurrection_site_build/img")"
LOCAL_FONT_DIR="$(realpath "../fashioning_insurrection_site_build/fonts")"
GIT_BUILD_REPO="https://github.com/Brown-University-Library/fashioning_insurrection_site_build.git"
REMOTE_SERVER=$FI_BUILD__REMOTE_SERVER          # from the dotenv-source
REMOTE_IMAGE_DIR=$FI_BUILD__REMOTE_IMAGE_DIR    # from the dotenv-source
REMOTE_FONT_DIR=$FI_BUILD__REMOTE_FONT_DIR      # from the dotenv-source

echo "vars prepared..."
echo "- LOCAL_BUILD_DIR: $LOCAL_BUILD_DIR"
echo "- LOCAL_IMAGE_DIR: $LOCAL_IMAGE_DIR"
echo "- LOCAL_FONT_DIR: $LOCAL_FONT_DIR"
echo "- GIT_BUILD_REPO: $GIT_BUILD_REPO"
echo "- REMOTE_SERVER: $REMOTE_SERVER"
echo "- REMOTE_IMAGE_DIR: $REMOTE_IMAGE_DIR"
echo "- REMOTE_FONT_DIR: $REMOTE_FONT_DIR"

## update the repo --------------------------------------------------
cd "$LOCAL_BUILD_DIR" || { echo "Error: Failed to change to directory $LOCAL_BUILD_DIR" >&2; exit 1; }
git pull $GIT_BUILD_REPO

## rsync the images and fonts ---------------------------------------
cd "$LOCAL_BUILD_DIR" || { echo "Error: Failed to change to directory $LOCAL_BUILD_DIR" >&2; exit 1; }
rsync -avz --delete "$LOCAL_IMAGE_DIR" "$REMOTE_SERVER:$REMOTE_IMAGE_DIR"
rsync -avz --delete "$LOCAL_FONT_DIR" "$REMOTE_SERVER:$REMOTE_FONT_DIR"

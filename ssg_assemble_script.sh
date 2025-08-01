## ------------------------------------------------------------------
## build-script for assembling the stand-alone SSG specified in the `ssg_assemble_dotenv.sh` file
##
## usage: `bash ./ssg_assemble_script.sh`
## see README.md for more info
## ------------------------------------------------------------------

echo " "
echo ":: starting ssg_assemble_script.sh"
echo " "

## confirm we're in the correct `ssg_assemble_script_project` directory ---------
script_dir="$(realpath "$(dirname "$0")")" || { echo "Error: Failed to get realpath of directory $(dirname "$0")" >&2; exit 1; }
cd "$script_dir" || { echo "Error: Failed to change to directory $script_dir" >&2; exit 1; }
echo ":: confirmed we're starting from the correct directory: $script_dir"
echo " "

## source the dotenv file -------------------------------------------
dotenv_path="$(realpath "../ssg_assemble_dotenv.sh")" || { echo "Error: Failed to get realpath of ssg_assemble_dotenv.sh" >&2; exit 1; }
source "$dotenv_path" || { echo "Error: Failed to source $dotenv_path" >&2; exit 1; }
echo ":: envars successfully sourced from: $dotenv_path"
echo " "

## set vars ---------------------------------------------------------
LOCAL_BUILD_DIR="$(realpath "../fashioning_insurrection_site_build")" || { echo "Error: Build directory not found at $(cd .. && pwd)/fashioning_insurrection_site_build" >&2; exit 1; }
LOCAL_IMAGE_DIR="$(realpath "../fashioning_insurrection_site_build/img")" || { echo "Error: Image directory not found at $(cd .. && pwd)/fashioning_insurrection_site_build/img" >&2; exit 1; }
LOCAL_FONT_DIR="../fashioning_insurrection_site_build/fonts"
GIT_BUILD_REPO="https://github.com/Brown-University-Library/fashioning_insurrection_site_build.git"
REMOTE_SERVER=$SSG_ASSEMBLE__REMOTE_SERVER          # from the dotenv-source
REMOTE_IMAGE_DIR=$SSG_ASSEMBLE__REMOTE_IMAGE_DIR    # from the dotenv-source
REMOTE_FONT_DIR=$SSG_ASSEMBLE__REMOTE_FONT_DIR      # from the dotenv-source
echo ":: vars successfully prepared..."
echo "- LOCAL_BUILD_DIR: $LOCAL_BUILD_DIR"
echo "- LOCAL_IMAGE_DIR: $LOCAL_IMAGE_DIR"
echo "- LOCAL_FONT_DIR: $LOCAL_FONT_DIR"
echo "- GIT_BUILD_REPO: $GIT_BUILD_REPO"
echo "- REMOTE_SERVER: $REMOTE_SERVER"
echo "- REMOTE_IMAGE_DIR: $REMOTE_IMAGE_DIR"
echo "- REMOTE_FONT_DIR: $REMOTE_FONT_DIR"
echo " "

## update the repo --------------------------------------------------
cd "$LOCAL_BUILD_DIR" || { echo "Error: Failed to change to directory $LOCAL_BUILD_DIR" >&2; exit 1; }
git pull $GIT_BUILD_REPO
echo ":: repo successfully updated from github"
echo " "

## rsync the images and fonts ---------------------------------------
cd "$LOCAL_BUILD_DIR" || { echo "Error: Failed to change to directory $LOCAL_BUILD_DIR" >&2; exit 1; }
rsync -avz --delete "$REMOTE_SERVER:$REMOTE_IMAGE_DIR/" "$LOCAL_IMAGE_DIR"
echo ":: images successfully rsync'd"
echo " "
rsync -avz --delete "$REMOTE_SERVER:$REMOTE_FONT_DIR/" "$LOCAL_FONT_DIR"
echo ":: fonts successfully rsync'd"
echo " "

cd "$script_dir" || { echo "Error: Failed to change to directory $script_dir" >&2; exit 1; }
echo ":: ssg_assemble_script.sh completed successfully"
echo " "

#!/bin/sh

__templates_dir=$(realpath $0 | xargs dirname | xargs dirname)
__working_dir=$(pwd)

# directory to copy files to
destname="${1:-tmp}"
selected_template=""

templates=($(ls "$__templates_dir/templates"))

PS3="Select web template to apply:"
select option in ${templates[@]}; do
  if [[ -z $selected_template ]]; then
    selected_template="$option"
    break
  fi
done

# create project directory
if [ ! -d "$__working_dir/$destname" ]; then
  echo "create $destname/"
  mkdir -p "$__working_dir/$destname"
fi

# directories
template_dir="$__templates_dir/templates/$selected_template"
project_dir="$__working_dir/$destname"

# file, source directory
function copy_file() {
  if [[ $(dirname "$2/$1") != "$2" ]]; then
    local folder=$(dirname $1)

    echo "create $destname/$folder/"
    mkdir -p "$project_dir/$folder"

    echo "create $destname/$1"
    cp -r "$2/$1" "$project_dir/$folder/"
  else
    echo "create $destname/$1"
    cp -r "$2/$1" "$project_dir/"
  fi
}

# copy template files
for f in $(ls "$template_dir"); do
  copy_file "$f" "$template_dir"
done

# copy generic files
copy_file ".gitignore" "$__templates_dir"
copy_file ".vscode" "$__templates_dir"
copy_file "scripts/patch.sh" "$__templates_dir"

# update package name
sed -i '' -e "s/web-template/$(basename $destname)/" "$project_dir/package.json"
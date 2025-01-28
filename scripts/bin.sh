#!/bin/zsh

__projectname=$(realpath $0 | xargs dirname | xargs dirname)
__workingname=$(pwd)

# directory to copy files to
destname="${1:-tmp}"
selected_template=""

templates=($(ls "$__projectname/templates"))

PS3="Select web template to apply:"
select option in ${templates[@]}; do
  if [[ -z $selected_template ]]; then
    selected_template="$option"
    break
  fi
done

# create project directory
if [ ! -d "$__workingname/$destname" ]; then
  echo "create $destname"
  mkdir -p "$__workingname/$destname"
fi

# directories
template_dir="$__projectname/templates/$selected_template"
project_dir="$__workingname/$destname"

# file, source directory
function copy_file() {
  echo "create $destname/$1"
  cp -r "$2/$1" "$project_dir/"
}

# copy template files
for f in $(ls "$template_dir"); do
  copy_file "$f" "$template_dir"
done

# copy generic files
copy_file ".gitignore" "$__projectname"
copy_file ".vscode" "$__projectname"

# update package name
sed -i '' -e "s/web-template/$(basename $destname)/" "$project_dir/package.json"
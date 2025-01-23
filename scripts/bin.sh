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

# copy template files
template_dir="$__projectname/templates/$selected_template"
project_dir="$__workingname/$destname"

for f in $(ls "$template_dir"); do
  echo "create $destname/$f"
  cp -r "$template_dir/$f" "$project_dir/"
done

# update package name
sed -i '' -e "s/web-template/$(basename $destname)/" "$project_dir/package.json"
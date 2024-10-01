#!/bin/zsh

options="$(ls templates)"
template=""

PS3="Select a template to apply: "
select option in $options; do
  if [[ -z $template ]]; then
    template="$option"
    break
  fi
done

echo "'$template' template was chosen."

function copy() {
  echo "cp -r $1 $2"
  cp -r "$1" "$2"
}

# clean up
rm -rf plugins src

template_dir="templates/$template"
for f in $(ls $template_dir); do
  copy "$template_dir/$f" "./"
done

echo "done"
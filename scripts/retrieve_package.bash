#!/bin/bash
if [ -z "$1" ]
  then
    echo "Please add the path to the package.xml as the first argument"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "Please add name of org as the second argument"
    exit 1
fi

mv sfdx-project.json original-sfdx-project.json

node scripts/change_default_path.js "$1"

if [ $? -ne 0 ]; then
  mv original-sfdx-project.json sfdx-project.json
  exit 1
fi

sf project retrieve start --manifest "$1"/package.xml -o "$2"

rm sfdx-project.json

mv original-sfdx-project.json sfdx-project.json
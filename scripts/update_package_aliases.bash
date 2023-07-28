sfdx force:package:list -v dev_org_v8 --json > packageList.json

node scripts/update_package_aliases.js "$1"
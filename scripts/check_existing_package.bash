packageList=$(sfdx force:package:list -v dev_org_v8 --json)
if echo "$packageList" | jq -e '.result | if . == null then [] else . end | map(select(.Name == "usermgmt")) | length == 1' > /dev/null; then
  echo "Package already exists"
  export PACKAGE_EXISTS=true
else
  echo "Package does not exist"
  export PACKAGE_EXISTS=false
fi
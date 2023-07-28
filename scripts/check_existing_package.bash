packageList=$(sfdx force:package:list -v dev_org_v8 --json)
if echo "$packageList" | jq -e '.result | if . == null then [] else . end | map(select(.Name == "usermgmt")) | length == 1' > /dev/null; then
  echo true
else
  echo false
fi
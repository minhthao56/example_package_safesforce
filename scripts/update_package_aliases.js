const fs = require('fs');

const packageList = fs.readFileSync('packageList.json', 'utf8');
const sfdxProjectJson = fs.readFileSync('sfdx-project.json', 'utf8');
const namePath = process.argv[2];

const packageListJSON = JSON.parse(packageList)
const fileJSON = JSON.parse(sfdxProjectJson)
const id = packageListJSON.result.find((item) => item.Name === namePath).Id;
fileJSON.packageAliases[namePath] = id;

const updatedJSON = JSON.stringify(fileJSON, null, 2);
fs.writeFileSync('sfdx-project.json', updatedJSON, 'utf8');

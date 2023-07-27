const fs = require('fs');

const sfdxProjectJson = fs.readFileSync('original-sfdx-project.json', 'utf8');
const namePath = process.argv[2];

const fileJSON = JSON.parse(sfdxProjectJson)


const allPaths = fileJSON.packageDirectories.map((item) => {
    return item.path;
})

if (!allPaths.includes(namePath)) {
  throw new Error(`Path ${namePath} not found in sfdx-project.json`);
}

const changedDefaultPath = fileJSON.packageDirectories.map((item) => {
    if (item.path === namePath) {
        item.default = true;
    }else{
        item.default = false;
    }
    return item;

});
fileJSON.packageDirectories = changedDefaultPath;

const updatedJSON = JSON.stringify(fileJSON, null, 2);
fs.writeFileSync('sfdx-project.json', updatedJSON, 'utf8');

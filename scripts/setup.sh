#!/bin/bash

# SOURCE=packages/cli/src/index.ts

# ts-node -r tsconfig-paths/register $SOURCE $@

# ts-node -r tsconfig-paths/register packages/compose/src/lib/debug.ts $@

# ts-node -r tsconfig-paths/register packages/compose/src/lib/testmake.ts $@

# Reset
reset='\033[0m' # Text Reset

# Regular Colors
black='\033[0;30m'  # Black
red='\033[0;31m'    # Red
green='\033[0;32m'  # Green
yellow='\033[0;33m' # Yellow
blue='\033[0;34m'   # Blue
purple='\033[0;35m' # Purple
cyan='\033[0;36m'   # Cyan
white='\033[0;37m'  # White

# Bold
bblack='\033[1;30m'  # Black
bred='\033[1;31m'    # Red
bgreen='\033[1;32m'  # Green
byellow='\033[1;33m' # Yellow
bblue='\033[1;34m'   # Blue
bpurple='\033[1;35m' # Purple
bcyan='\033[1;36m'   # Cyan
bwhite='\033[1;37m'  # White

# High Intensity
iblack='\033[0;90m'  # Black
ired='\033[0;91m'    # Red
igreen='\033[0;92m'  # Green
iyellow='\033[0;93m' # Yellow
iblue='\033[0;94m'   # Blue
ipurple='\033[0;95m' # Purple
icyan='\033[0;96m'   # Cyan
iwhite='\033[0;97m'  # White

WORKSPACE_NAME="lazystack"

clear

# install go zed/zq
# go install github.com/brimdata/zed/cmd/{zed,zq}@latest

# git remote add origin git@github.com:viviflowt/lazystack.git
# git push --set-upstream origin master

ws_reset() {
    npm cache clean --force --silent 2>/dev/null

    rm -rf node_modules 2>/dev/null
    rm -rf dist 2>/dev/null
    rm -rf coverage 2>/dev/null

    rm -rf /tmp/setup 2>/dev/null
    mkdir /tmp/setup 2>/dev/null
    mkdir /tmp/setup/bak 2>/dev/null
    ls -a /tmp/setup/bak
    ls -la /tmp/setup

    BACKUP_FILENAME=$(openssl rand -hex 20)
    echo -e ":: $BACKUP_FILENAME.tar.gz"
    tar -zcvf "/tmp/setup/bak/$BACKUP_FILENAME.tar.gz" .
    ls -a /tmp/setup

    cp setup.sh setup.sh.bak
    cp setup.sh /tmp/setup/setup.sh.bak

    rm -rf packages 2>/dev/null
    rm -rf .vscode 2>/dev/null

    rm -rf tools 2>/dev/null
    rm -rf package-lock.json 2>/dev/null
    rm -rf package.json 2>/dev/null
    rm -rf nx.json 2>/dev/null
    rm -rf workspace.json 2>/dev/null
    rm -rf tsconfig.base.json 2>/dev/null
    rm -rf tsconfig.json 2>/dev/null
    rm -rf .prettierrc 2>/dev/null
    rm -rf .prettierignore 2>/dev/null
    rm -rf .editorconfig 2>/dev/null
}

ws_create() {
    npm install --silent -g create-nx-workspace@latest 2>/dev/null
    npx create-nx-workspace@latest --skip-git true --pm npm --ci github --preset ts --name ${WORKSPACE_NAME} --nxCloud true cli nx workspace
    rm -rf workspace/node_modules 2>/dev/null
    rsync -rtv --progress workspace/ ./
    rm -rf workspace 2>/dev/null
    npm install --ignore-scripts
    npm audit
}

ws_install() {
    for i in "$@"; do
        echo -e " ${iblack}›${reset} ${white}" "$i" "${reset}"
        sleep 0.5
    done
    echo -en "\n"
    if [ "$1" == "-D" ]; then
        shift
        npm install --save-dev --ignore-scripts --silent "$@" 2>/dev/null
    else
        npm install --save --ignore-scripts --silent "$@" 2>/dev/null
    fi
}

ws_update() {
    npm install --ignore-scripts --silent 2>/dev/null
    npm prune --ignore-scripts --silent 2>/dev/null
    npx --ignore-scripts --silent typesync 2>/dev/null
}

ws_reset
ws_create
ws_update

ws_install -D @nrwl/eslint-plugin-nx @nrwl/node @nrwl/workspace @nrwl/jest
ws_update
ws_install -D ts-node tslib typesync type-fest syncpack @faker-js/faker is-ci commitizen husky
ws_install lodash eventemitter2 bluebird
ws_install dotenv cross-env rimraf concurrently
ws_install reflect-metadata tsyringe
# ws_install fs-extra fast-glob micromatch
ws_install chalk@4.1.2 easy-table
# ws_install commander cli-highlight detect-indent
# ws_install toml yaml ini fastest-levenshtein object-diff stream-chain stream-json
ws_update

# npm_install -D lodash reflect-metadata
# ws_install lodash reflect-metadata

cat <<EOF >script.js
#!/usr/bin/env node

const fs = require('fs');
const json = JSON.parse(fs.readFileSync("tsconfig.base.json", 'utf8'));

const newJson = {
    ...json,
    compilerOptions: {
        ...json.compilerOptions,
        module: "commonjs",
        esModuleInterop: true,
        allowSyntheticDefaultImports: true,
    }
}
console.log(JSON.stringify(newJson, null, 2));




    JSON.stringify({ extends: "./tsconfig.base.json" }) )
          
    
fs.writeFileSync("tsconfig.dev.json", JSON.stringify(newJson, null, 2));
EOF

chmod +x script.js
./script.js

touch

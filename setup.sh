#!/bin/bash

clear

WORKSPACE_NAME="viviflowt"

npx create-nx-workspace@latest --skip-git true --pm yarn --ci github --preset ts --name ${WORKSPACE_NAME:-viviflowt} --nxCloud false cli nx workspace
# ---------------------------------------------------------------------------------------------------------------------
rm -rf workspace/node_modules
cp -rf ./workspace/* ./
cp -rf ./workspace/.* ./
rm -rf ./workspace
# ---------------------------------------------------------------------------------------------------------------------
yarn install
# ---------------------------------------------------------------------------------------------------------------------
yarn add -D @nrwl/js @nrwl/linter @nrwl/eslint-plugin-nx @nrwl/node @nrwl/workspace
yarn add -D @nrwl/jest jest-extended
yarn add -D typesync ts-node tslib type-fest tsconfig-paths
# ---------------------------------------------------------------------------------------------------------------------
yarn add -D -s commitizen
commitizen init cz-conventional-changelog --yarn --dev --exact
npm pkg set scripts.commit="cz"
# ---------------------------------------------------------------------------------------------------------------------
yarn add -D @faker-js/faker
yarn add -D dotenv dotenv-expand cross-env rimraf
yarn add tsyringe
yarn add chalk@4.1.2 commander inquirer@8.2.4 easy-table
yarn add lodash reflect-metadata
yarn add eventemitter2 bluebird fs-extra fast-glob micromatch
# ---------------------------------------------------------------------------------------------------------------------
npm pkg set scripts.tsd="ts-node -r tsconfig-paths/register"
npm pkg set scripts.dev="nx serve dev"
npm pkg set scripts.lint="nx run-many --target=lint --all=true --maxParallel=2"
npm pkg set scripts.build-all="nx run-many --target=build --all=true --maxParallel=2 --skip-nx-cache=true"
# ---------------------------------------------------------------------------------------------------------------------
echo -e "\nInstall @nrwl/nest? [y/N]"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  yarn add -D @nrwl/nest
  yarn add @nestjs/core @nestjs/common @nestjs/config @nestjs/platform-express @nestjs/microservices @nestjs/event-emitter
  yarn add class-validator class-transformer zod
  yarn add @golevelup/nestjs-discovery
  echo -e "\n"
fi
# ---------------------------------------------------------------------------------------------------------------------
echo -e "\nInstall ngx-deploy-npm? [y/N]"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  yarn add -D ngx-deploy-npm
  echo "nx generate ngx-deploy-npm:install"
  echo -e "\n"
fi
# ---------------------------------------------------------------------------------------------------------------------

npx typesync
echo -e "Done!\n"

# 168

#!/bin/bash

SOURCE=packages/config/src/lib/env/config-ini.ts

ts-node -r tsconfig-paths/register $SOURCE $@

typesync

yarn

yarn remove @nrwl/js @nrwl/node @nrwl/linter @nrwl/eslint-plugin-nx @nrwl/workspace @nrwl/jest jest-extended

yarn
typesync
nx reset

yarn add @nrwl/js @nrwl/node @nrwl/linter @nrwl/eslint-plugin-nx @nrwl/workspace @nrwl/jest jest-extended
typesync
nx reset

#!/bin/bash

# clear

# rm -rf dist 2>/dev/null

# nodemon --quiet dist/index.js

# node dist/index.js $@

# ts-node -r tsconfig-paths/register "$@"

ts-node -r tsconfig-paths/register packages/nestjs-config/src/main.ts "$@"

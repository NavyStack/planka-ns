#!/bin/bash
set -e
node db/init.js
node app.js --prod "$@" &
nginx -g "daemon off;"
#!/usr/bin/env bash

git checkout main
git pull
git add .
git commit -m "update"
git push origin main --no-verify

cd ..
git pull
git add .
git commit -m "update"
git push origin main --no-verify
git submodule update --init

cd note
git checkout main

cd ..
git add .
git commit -m "update"
git push origin main --no-verify
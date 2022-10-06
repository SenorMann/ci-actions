#!/bin/bash

EMAIL=$(eval echo \$${GIT_USER_EMAIL})
USERNAME=$(eval echo \$${GIT_USER_NAME})

git config user.email "$GIT_USER_EMAIL"
git config user.name "$GIT_USER_NAME"

git config user.email 
git config user.name 
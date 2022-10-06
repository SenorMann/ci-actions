#!/bin/bash

EMAIL=$(eval echo \$${GIT_USER_EMAIL})
USERNAME=$(eval echo \$${GIT_USER_NAME})

git config user.email "$(eval echo ${GIT_USER_NAME})"
git config user.name eval echo "$USERNAME"

git config user.email 
git config user.name 
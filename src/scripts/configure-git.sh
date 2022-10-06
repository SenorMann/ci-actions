#!/bin/bash

EMAIL=$(eval echo \$${GIT_USER_EMAIL})
USERNAME=$(eval echo \$${GIT_USER_NAME})

git config user.email "$EMAIL"
git config user.name "$USERNAME"

git config user.email 
git config user.name 
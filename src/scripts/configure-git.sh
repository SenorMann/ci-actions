#!/bin/bash

EMAIL=${!PARAM_GIT_USER_EMAIL}
USERNAME=${!PARAM_GIT_USER_NAME}

git config user.email "$EMAIL"
git config user.name "$USERNAME"

git config user.email 
git config user.name 
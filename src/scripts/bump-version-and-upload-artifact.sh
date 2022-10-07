#!/bin/bash

shopt -s nocasematch

# Read environment from provided keys
NPM_REGISTRY=${!PARAM_NPM_REGISTRY}
NPM_REGISTRY_AUTH=${!PARAM_NPM_REGISTRY_AUTH}
NPM_REGISTRY_EMAIL=${!PARAM_NPM_REGISTRY_EMAIL}

get_bump_type() {
  commit_msg=$(git log -1 --pretty=%B)
  if [[ "$commit_msg" =~ .*"[skip ci] Upgrade to ".* ]]; then
    echo ""
  elif [[ "$commit_msg" =~ .*"BREAKING CHANGE".* ]]; then
    echo "major"
  elif [[ "$commit_msg" =~ .*"feature/".* ]]; then
    echo "minor"
  else
    echo "patch"
  fi
}

bump_type=$(get_bump_type)

if [[ -n "$bump_type" ]]; then
  npm version "$bump_type" -m "[skip ci] Upgrade to %s"
  npm shrinkwrap && npm ci
  { 
    echo always-auth=true
    echo _auth="$NPM_REGISTRY_AUTH"
    echo email="$NPM_REGISTRY_EMAIL"
    echo registry="$NPM_REGISTRY"
  } >> .npmrc
  cat .npmrc
  if [[ "$DRY_RUN" == "1" ]]; then
    npm publish --dry-run
  else
    git push && git push --tags
    npm publish
  fi
fi
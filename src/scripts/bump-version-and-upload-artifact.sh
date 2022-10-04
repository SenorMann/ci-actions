#!/bin/bash

shopt -s nocasematch

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

NPM_REGISTRY=$(eval echo "\$$NPM_REGISTRY")


bump_type=$(get_bump_type)

if [[ -n "$bump_type" ]]; then
  echo "ENV VARSSS"
  echo "${NPM_REGISTRY}"
  echo "END ECHO"
  npm version "$bump_type" -m "[skip ci] Upgrade to %s"
  npm shrinkwrap && npm ci
  { 
    echo always-auth=true
    echo _auth="$NPM_REGISTRY_AUTH"
    echo email="$NPM_REGISTRY_EMAIL"
    echo registry="$NPM_REGISTRY"
  } >> .npmrc
 
  if [[ "$DRY_RUN" == "1" ]]; then
    npm publish --dry-run
  else
    git push && git push --tags
    npm publish
  fi
fi
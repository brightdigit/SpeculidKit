#!/bin/bash

SWIFT_VER="5.3"

if [[ $TRAVIS_OS_NAME = 'osx' ]]; then
  echo "No Actions for macOS"
elif [[ $TRAVIS_OS_NAME = 'linux' ]]; then
  RELEASE_DOT=$(lsb_release -sr)
  RELEASE_NUM=${RELEASE_DOT//[-._]/}
  wget https://swift.org/builds/swift-${SWIFT_VER}-release/ubuntu${RELEASE_NUM}/swift-${SWIFT_VER}-RELEASE/swift-${SWIFT_VER}-RELEASE-ubuntu${RELEASE_DOT}.tar.gz
  tar xzf swift-${SWIFT_VER}-RELEASE-ubuntu${RELEASE_DOT}.tar.gz
fi

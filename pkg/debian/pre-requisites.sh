#!/usr/bin/env bash


source ../../util/util.sh

print_info "Installing prerequisites"

$SUDO apt-get update
$SUDO apt-get install -y unzip \
  gnupg \
  ca-certificates \
  curl \
  lsb-release \
  python3-pip

print_info "Pre-requisites installed successfully!"

#!/bin/bash

# Move into the directory where this script is located (the root dir)
cd "$(dirname "$0")" || exit

# Define the name of the temporary directory to build in
BUILD_DIR="/tmp/tmp_lambda_build_dfy2c84w"

# Create a directory to store the build
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cp -R src/* "$BUILD_DIR/"

# Install the required packages directly into the build directory
python -m pip install -r requirements.txt --target="$BUILD_DIR/"

FROM quay.io/devfile/universal-developer-image:latest

# Some examples:
# quay.io/devfile/base-developer-image:ubi9-latest
# quay.io/devfile/universal-developer-image:latest
# quay.io/devfile/universal-developer-image:ubi8-latest
# Check out this repos for options:
# quay.io/repository/devfile/universal-developer-image?tab=tags
# quay.io/repository/devfile/base-developer-image?tab=tags
# https://github.com/devfile/developer-images

RUN sudo dnf update

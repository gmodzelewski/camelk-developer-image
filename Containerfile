FROM quay.io/devfile/base-developer-image:ubi9-latest
# Some examples:
# quay.io/devfile/base-developer-image:ubi9-latest
# quay.io/devfile/universal-developer-image:latest
# quay.io/devfile/universal-developer-image:ubi8-latest
# Check out this repos for options:
# quay.io/repository/devfile/universal-developer-image?tab=tags
# quay.io/repository/devfile/base-developer-image?tab=tags
# https://github.com/devfile/developer-images

LABEL maintainer="Georg Modzelewski"
LABEL io.k8s.display-name="camelk-developer-image"

# Define the version of Camel-K CLI to install
ENV KAMEL_VERSION=2.3.0

USER 0
RUN dnf update -y && \ 
    dnf install -y util-linux-user zsh tar gzip && \
    dnf clean all

# install camel k cli (= kamel)
RUN curl -L https://github.com/apache/camel-k/releases/download/v${KAMEL_VERSION}/camel-k-client-${KAMEL_VERSION}-linux-amd64.tar.gz -o camel-k.tar.gz && \ 
    tar xf camel-k.tar.gz && \
    sha512sum --check kamel.sha512 && \
    mv kamel /usr/local/bin/kamel && \
    chmod +x /usr/local/bin/kamel && \
    rm camel-k.tar.gz kamel.sha512

# install oh my zsh for terminal greatness
RUN chsh -s /bin/zsh 
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

USER 10001
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
ENV KAMEL_VERSION=2.2.0

USER 0
RUN dnf update -y && \ 
    dnf install -y util-linux-user zsh tar gzip java-17-openjdk && \
    dnf clean all

# install camel k cli (= kamel)
RUN curl -L https://github.com/apache/camel-k/releases/download/v${KAMEL_VERSION}/camel-k-client-${KAMEL_VERSION}-linux-amd64.tar.gz -o camel-k.tar.gz && \ 
    tar xf camel-k.tar.gz && \
    sha512sum --check kamel.sha512 && \
    mv kamel /usr/local/bin/kamel && \
    chmod +x /usr/local/bin/kamel && \
    rm camel-k.tar.gz kamel.sha512

# install oc cli
RUN curl -O https://downloads-openshift-console.apps.ocp.ocp-gm.de/amd64/linux/oc.tar && \
    tar xf oc.tar && \
    mv oc /usr/local/bin/oc && \
    chmod +x /usr/local/bin/oc && \
    rm oc.tar
    
# install oh my zsh for terminal greatness
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chsh -s $(which zsh)

USER 10001
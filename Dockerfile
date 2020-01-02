FROM alpine:3

ENV HELM_VERSION=2.16.1
ENV KUBECTL_VERSION=1.16.3

RUN apk add --no-cache libintl curl ca-certificates file openssl && \
    apk add --no-cache --virtual build_deps gettext && \
    cp /usr/bin/envsubst /usr/local/bin/ && \
    curl -L https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /bin

RUN apk del build_deps curl

CMD ["/bin/sh"]
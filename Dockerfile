FROM walkero/amigagccondocker:os4-gcc11-afxgroup

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ENV PACKAGES="autoconf \
    autopoint \
    build-essential \
    ccache \
    libtool"

ENV OS4_SDK_PATH="/opt/sdk/ppc-amigaos"

RUN apt-get update && apt-get -y --no-install-recommends install ${PACKAGES};

WORKDIR /tmp

RUN curl -fsSL "https://git.walkero.gr/attachments/80898eda-b475-4aea-8c90-73cdf20ac25c" -o /tmp/libhyphen.lha && \
    lha -xfq2 libhyphen.lha && \
    \cp ./release/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "https://git.walkero.gr/attachments/4efcd967-e1c1-4aa4-b6ef-b96dff283689" -o /tmp/libnghttp2.lha && \
    lha -xfq2 libnghttp2.lha && \
    \cp ./release/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN git clone https://github.com/kas1e/Odyssey.git --depth 1 /tmp/Odyssey && \
    mkdir -p ${OS4_SDK_PATH}/local/common/include/devices && \
    cp /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/include/include_h/devices/* ${OS4_SDK_PATH}/local/common/include/devices/; \
    rm -rf /tmp/*;

RUN mv ${OS4_SDK_PATH}/include/include_h/openssl ${OS4_SDK_PATH}/include/include_h/openssl_amissl

WORKDIR /opt/code

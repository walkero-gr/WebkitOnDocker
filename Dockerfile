FROM walkero/amigagccondocker:os4-gcc11-2.1.2

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

WORKDIR /tmp

RUN git clone https://github.com/kas1e/Odyssey.git --depth 1 /tmp/Odyssey && \
    mkdir -p ${SDK_PATH}/local/common/include/devices && \
    cp /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/include/include_h/devices/* ${SDK_PATH}/local/common/include/devices/; \
    rm -rf /tmp/*; \
    \
    mv ${SDK_PATH}/include/include_h/openssl ${SDK_PATH}/include/include_h/openssl_amissl; \
    \
    curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libcairo/libcairo-1.14.10.lha" -o /tmp/libcairo.lha && \
        lha -xfq2 libcairo.lha && \
        \cp -R ./SDK/* ${SDK_PATH}/ && \
        rm -rf /tmp/*; \
    \
    curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/hyphen/hyphen-2.8.8.lha" -o /tmp/libhyphen.lha && \
    lha -xfq2 libhyphen.lha && \
    \cp -R ./SDK/* ${SDK_PATH}/ && \
    rm -rf /tmp/*;

WORKDIR /opt/code

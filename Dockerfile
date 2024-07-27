FROM walkero/amigagccondocker:os4-gcc11-2.1.2

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

WORKDIR /tmp

RUN git clone https://github.com/kas1e/Odyssey.git --depth 1 /tmp/Odyssey && \
    mkdir -p ${SDK_PATH}/local/common/include/devices && \
    cp /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/include/include_h/devices/* ${SDK_PATH}/local/common/include/devices/; \
    rm -rf /tmp/*;

RUN mv ${SDK_PATH}/include/include_h/openssl ${SDK_PATH}/include/include_h/openssl_amissl

WORKDIR /opt/code

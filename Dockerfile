FROM walkero/amigagccondocker:os4-gcc11-2.5.0

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

WORKDIR /tmp

RUN git clone https://github.com/kas1e/Odyssey.git --depth 1 /tmp/Odyssey && \
    mkdir -p ${SDK_PATH}/local/common/include/devices && \
    cp /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/include/include_h/devices/* ${SDK_PATH}/local/common/include/devices/; \
    rm -rf /tmp/*; \
    \
    mv ${SDK_PATH}/include/include_h/openssl ${SDK_PATH}/include/include_h/openssl_amissl; \
    sed -i 's/typedef void (*xmlStructuredErrorFunc) (void *userData, const xmlError *error);/typedef void (*xmlStructuredErrorFunc) (void *userData, xmlError *error);/g' \
        ${SDK_PATH}/local/clib4/include/libxml2/libxml/xmlerror.h; \
    sed -i 's/struct Lock/struct LockStruct/g' ${SDK_PATH}/include/include_h/dos/dosextens.h; \
    \
    curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libcairo/libcairo-1.14.10.lha" -o /tmp/libcairo.lha && \
        lha -xfq2 libcairo.lha && \
        \cp -R ./SDK/* ${SDK_PATH}/ && \
        rm -rf /tmp/*; \
    \
    curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/hyphen/hyphen-2.8.8.lha" -o /tmp/libhyphen.lha && \
        lha -xfq2 libhyphen.lha && \
        \cp -R ./SDK/* ${SDK_PATH}/ && \
        rm -rf /tmp/*; \
    \
    curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/fontconfig/fontconfig-2.14.2.lha" -o /tmp/fontconfig.lha && \
        lha -xfq2 fontconfig.lha && \
        \cp -R ./SDK/* ${SDK_PATH}/ && \
        rm -rf /tmp/*; \
    \
    curl -fsSL "https://github.com/AmigaLabs/libs-ports/raw/main/libxml2/libxml2-2.12.9.lha" -o /tmp/libxml2.lha && \
            lha -xfq2 libxml2.lha && \
            \cp -R ./SDK/* ${SDK_PATH}/ && \
            rm -rf /tmp/*; \
    \
    curl -fsSL "https://os4depot.net/share/utility/misc/asyncio.lha" -o /tmp/asyncio.lha && \
        lha -xfq2 asyncio.lha && \
        cp -R AsyncIO/include/* $SDK_PATH/local/clib4/include/ && \
        rm -rf /tmp/*; \
    \
    rm -rf $SDK_PATH/local/clib4/include/libav* \
        $SDK_PATH/local/clib4/include/libsw* \
        $SDK_PATH/local/clib4/include/opus \
        $SDK_PATH/local/clib4/lib/libav* \
        $SDK_PATH/local/clib4/lib/libsw* \
        $SDK_PATH/local/clib4/lib/libopus && \
    git clone https://github.com/AmigaLabs/webkitty.git --depth 1 /tmp/webkitty && \
        make -C /tmp/webkitty/ffmpeg -j $(shell nproc --ignore=2) && \
        cp -R /tmp/webkitty/ffmpeg/instdir/include/* $SDK_PATH/local/clib4/include/ && \
        cp -R /tmp/webkitty/ffmpeg/instdir/lib/* $SDK_PATH/local/clib4/lib/ && \
        rm -rf /tmp/*;

WORKDIR /opt/code

FROM walkero/amigagccondocker:ppc-amigaos-gcc11-newclib2 AS build-stage

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ENV PACKAGES="autoconf \
    autopoint \
    build-essential \
    ccache \
    libtool"

ENV OS4_SDK_PATH="/opt/sdk/ppc-amigaos"

RUN apt-get update && apt-get -y --no-install-recommends install ${PACKAGES};

WORKDIR /tmp
RUN curl -fsSL "https://github.com/afxgroup/clib2/releases/download/v1.0.0-beta-9/clib2.lha" -o /tmp/clib2.lha && \
    lha -xfq2 clib2.lha && \
    cp -r clib2 ${OS4_SDK_PATH}; \
    mkdir ${OS4_SDK_PATH}/local/clib2/include; \
    rm -rf /tmp/*;

RUN git clone https://github.com/kas1e/Odyssey.git --depth 1 /tmp/Odyssey && \
    cp -r /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/local/common/include/cairo ${OS4_SDK_PATH}/local/common/include/ && \
    cp -r /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/local/common/include/fontconfig ${OS4_SDK_PATH}/local/common/include/ && \
    cp -r /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/local/common/include/freetype ${OS4_SDK_PATH}/local/common/include/ && \
    cp /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/local/common/include/ft2build.h ${OS4_SDK_PATH}/local/common/include/ && \
    cp /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/local/newlib/lib/libcairo.a ${OS4_SDK_PATH}/local/newlib/lib/; \
    rm -rf /tmp/*;

# RUN curl -fsSL "https://github.com/3246251196/icu/raw/main/icu4c/source/libicu.lha" -o /tmp/libicu.lha && \
RUN curl -fsSL "https://github.com/3246251196/icu/raw/fa4764661f6c34369ccbc02cc5d41daab7ae875b/icu4c/source/libicu.lha" -o /tmp/libicu.lha && \
    lha -xfq2 libicu.lha && \
    \cp ./libicu/SDK/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "https://github.com/3246251196/libpng/raw/libpng16/libpng.lha" -o /tmp/libpng.lha && \
    lha -xfq2 libpng.lha && \
    \cp ./libpng/SDK/* ${OS4_SDK_PATH}/local/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "https://git.walkero.gr/attachments/80898eda-b475-4aea-8c90-73cdf20ac25c" -o /tmp/libhyphen.lha && \
    lha -xfq2 libhyphen.lha && \
    \cp ./release/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "https://git.walkero.gr/attachments/4efcd967-e1c1-4aa4-b6ef-b96dff283689" -o /tmp/libnghttp2.lha && \
    lha -xfq2 libnghttp2.lha && \
    \cp ./release/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "https://git.walkero.gr/attachments/378ecfcc-7874-4856-b604-f159e8ddc206" -o /tmp/libpsl.lha && \
    lha -xfq2 libpsl.lha && \
    \cp ./release/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "https://git.walkero.gr/attachments/6330c85d-b0f6-4a66-821e-5a0e71e658dc" -o /tmp/libopenjp2.lha && \
    lha -xfq2 libopenjp2.lha && \
    \cp ./SDK/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "https://github.com/3246251196/libxml2/raw/master/libxml2.lha" -o /tmp/libxml2.lha && \
    lha -xfq2 libxml2.lha && \
    \cp ./libxml2/SDK/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

RUN curl -fsSL "http://os4depot.net/share/development/library/graphics/libjpeg.lha" -o /tmp/libjpeg.lha && \
    lha -xfq2 libjpeg.lha && \
    mkdir ./SDK/Local/common/include/libjpeg && \
    mv ./SDK/Local/common/include/j*.h ./SDK/Local/common/include/libjpeg/ && \
    \cp ./SDK/Local/* ${OS4_SDK_PATH}/local/ -R && \
    rm -rf /tmp/*;

WORKDIR /opt/code

# RUN git clone https://github.com/walkero-gr/webkitty.git --branch amigaos_2.36.8 --single-branch /opt/code/webkitty

# WORKDIR /opt/code/webkitty

# The following steps can be changed to get the final build binaries
# RUN make jscore-amigaos
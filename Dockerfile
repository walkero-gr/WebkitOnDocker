FROM walkero/amigagccondocker:ppc-amigaos-gcc11-newclib2 AS build-stage

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ENV PACKAGES="build-essential \
    ccache"

ENV OS4_SDK_PATH="/opt/sdk/ppc-amigaos"

RUN apt-get update && apt-get -y --no-install-recommends install ${PACKAGES};

WORKDIR /tmp
RUN curl -fsSL "https://walkero.gr/betas/clib2_beta8_selfcompiled_20221221.tar.xz" -o /tmp/clib2.tar.xz && \
    tar xvf clib2.tar.xz && \
    cp -r clib2 ${OS4_SDK_PATH}; \
    rm -rf /tmp/*;

RUN git clone https://github.com/kas1e/Odyssey.git --depth 1 /tmp/Odyssey && \
	cp -r /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/local/common/include/cairo ${OS4_SDK_PATH}/local/newlib/include/ && \
	cp /tmp/Odyssey/odyssey-r155188-1.23_SDK/SDK/local/newlib/lib/libcairo.a ${OS4_SDK_PATH}/local/newlib/lib/; \
	rm -rf /tmp/*;

RUN curl -fsSL "https://github.com/3246251196/icu/raw/main/icu4c/source/libicu.lha" -o /tmp/libicu.lha && \
    lha -xfq2 libicu.lha && \
    \cp ./libicu/SDK/* ${OS4_SDK_PATH}/ -R && \
    rm -rf /tmp/*;

# RUN git clone https://github.com/walkero-gr/webkitty.git --branch amigaos_2.36.8 --single-branch /opt/code/webkitty

# WORKDIR /opt/code/webkitty

# The following steps can be changed to get the final build binaries
# RUN make jscore-amigaos
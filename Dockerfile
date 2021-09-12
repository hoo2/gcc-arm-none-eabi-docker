#
# Dockerfile for gcc-arm-none-eabi image
# 
# Copyright (C) 2021 Christos Choutouridis <hoo2@hoo2.net>
#
# This program is distributed under the MIT licence
# You should have received a copy of the MIT licence along with this program.
# If not, see <https://www.mit.edu/~amini/LICENSE.md>.
#
# versions: 
# ---------
#  release: 7-2017-q4-major
#    alias: 7.2.1, 7.2, 7

FROM ubuntu:18.04

ARG VERSION
ENV GCC_ARM_PATH        /usr/local
ENV GCC_VERSION         7.2.1

RUN apt-get update                           && \
    apt-get upgrade -y                       && \
    apt-get install --no-install-recommends -y  \
        build-essential                         \
        git                                     \
        bzip2                                   \
        wget                                    \
        ca-certificates                      && \
    apt-get clean                            && \
    rm -rf /var/lib/apt/lists/*              && \
    mkdir -p ${GCC_ARM_PATH}

# TODO:
# Add link for every release
ENV LINK_7_2017_q4_major \
https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2?revision=375265d4-e9b5-41c8-bf23-56cbe927e156?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2017-q4-major

# TODO:
# Add a case for every release
RUN echo "Install version: ${VERSION}" &&   \
    case "${VERSION}" in                    \
    "7-2017-q4-major")                      \
        wget -c ${LINK_7_2017_q4_major} -O -| tar -xj -C ${GCC_ARM_PATH}  ;;    \
    *)                                      \
        false || echo "Non supported version passed!"  ;;                       \
    esac

ENV PATH "${GCC_ARM_PATH}/gcc-arm-none-eabi-${VERSION}/bin:$PATH"

# Start bash login shell
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash", "-i"]
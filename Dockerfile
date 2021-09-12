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
#  release: 10-2020-q4-major
#    alias: 10.2.1, 10.2, 10
#  release: 9-2019-q4-major
#    alias: 9.2.1, 9.2, 9
#  release: 8-2018-q4-major
#    alias: 8.2.1, 8.2, 8
#  release: 7-2017-q4-major
#    alias: 7.2.1, 7.2, 7

FROM ubuntu:18.04

ARG VERSION
ENV GCC_ARM_PATH        /usr/local
ENV GCC_VERSION         10.2.1

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

ENV LINK_8_2018_q4_major \
https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2?revision=ab7c81a3-cba3-43be-af9d-e922098961dd?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,8-2018-q4-major

ENV LINK_9_2019_q4_major \
https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2?revision=108bd959-44bd-4619-9c19-26187abf5225&hash=8B0FA405733ED93B97BAD0D2C3D3F62A

ENV LINK_10_2020_q4_major \
https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2?revision=ca0cbf9c-9de2-491c-ac48-898b5bbc0443&hash=B47BBB3CB50E721BC11083961C4DF5CA

# TODO:
# Add a case for every release
RUN echo "Install version: ${VERSION}" &&   \
    case "${VERSION}" in                    \
    "7-2017-q4-major")                      \
        wget -c ${LINK_7_2017_q4_major} -O -| tar -xj -C ${GCC_ARM_PATH}  ;;    \
    "8-2018-q4-major")                      \
        wget -c ${LINK_8_2018_q4_major} -O -| tar -xj -C ${GCC_ARM_PATH}  ;;    \
    "9-2019-q4-major")                      \
        wget -c ${LINK_9_2019_q4_major} -O -| tar -xj -C ${GCC_ARM_PATH}  ;;    \
    "10-2020-q4-major")                      \
        wget -c ${LINK_10_2020_q4_major} -O -| tar -xj -C ${GCC_ARM_PATH}  ;;    \
    *)                                      \
        false || echo "Non supported version passed!"  ;;                       \
    esac

ENV PATH "${GCC_ARM_PATH}/gcc-arm-none-eabi-${VERSION}/bin:$PATH"

# Start bash login shell
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash", "-i"]
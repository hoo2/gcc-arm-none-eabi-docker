# A Docker image for providing gnu-arm cross compilers as containers

This image provides bare metal (arm-none-eabi-gxx) compiler collection as a container. The binaries are taken directly from [here](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads) without any modifications.

The repo of the project can be found [here](https://github.com/hoo2/gcc-arm-none-eabi-docker).

## Supported tags

Bellow is the list with the supported tags as links to the git release

  * [`9.2.1`, `9.2`, `9`, `9-2019-q4-major`](https://github.com/hoo2/gcc-arm-none-eabi-docker/blob/896c1e8363f03a9a0eaee1c4127360bd0e093479/Dockerfile)
  * [`8.2.1`, `8.2`, `8`, `8-2018-q4-major`](https://github.com/hoo2/gcc-arm-none-eabi-docker/blob/33859017c21f3f0f0e86857810ed3fee1b8ddcb3/Dockerfile)
  * [`7.2.1`, `7.2`, `7`, `7-2017-q4-major`](https://github.com/hoo2/gcc-arm-none-eabi-docker/blob/972d2deac4173756493056a7bd997d3bad7f94d0/Dockerfile)

## What is GCC?

The GNU Compiler Collection (GCC) is a compiler system produced by the GNU Project that supports various programming languages. GCC is a key component of the GNU toolchain. The Free Software Foundation (FSF) distributes GCC under the GNU General Public License (GNU GPL). GCC has played an important role in the growth of free software, as both a tool and an example.

see: https://en.wikipedia.org/wiki/GNU_Compiler_Collection

## What is arm-none-eabi?

The GNU Arm Embedded Toolchain is a ready-to-use, open-source suite of tools for C, C++ and assembly programming. The GNU Arm Embedded Toolchain targets the 32-bit Arm Cortex-M, and Arm Cortex-R processor families. The GNU Arm Embedded Toolchain includes the GNU Compiler (GCC) and is available free of charge directly from Arm for embedded software development on Windows, Linux, and Mac OS X operating systems.


## How to use this image

### 1) Start a GCC instance running your app

The most straightforward way to use this image is to use a gcc container as both the build and runtime environment. In your Dockerfile, writing something along the lines of the following will compile and run your project:

    FROM gcc-arm-none-eabi:latest
    COPY . /usr/src/myapp
    WORKDIR /usr/src/myapp
    RUN gcc -o myapp main.c
    CMD ["./myapp"]

Then, build and run the Docker image:

    $ docker build -t appImage .
    $ docker run -it --rm --name my-running-app appImage

### 2) Compile your app inside the Docker container

There may be occasions where it is not appropriate to run your app inside a container. To compile, but not run your app inside the Docker instance, you can write something like:

    $ docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc-arm-none-eabi:7.2 gcc -o myapp myapp.c

This will add your current directory, as a volume, to the container, set the working directory to the volume, and run the command gcc -o myapp myapp.c. This tells gcc to compile the code in myapp.c and output the executable to myapp.

### 3) Alternatively, if you have a Makefile, you can instead run the make command inside your container

    $ docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc-arm-none-eabi make

## TODO

  1. Add support for other platforms besides linux_x64
#!/bin/bash

set -euo pipefail
source $(dirname $0)/var.sh

FLAGS=(
  "${FFMPEG_CONFIG_FLAGS_BASE[@]}"
  --target-os=none        # use none to prevent any os specific configurations
  --arch=x86_32           # use x86_32 to achieve minimal architectural optimization
  --enable-cross-compile  # enable cross compile
  --disable-x86asm        # disable x86 asm
  --disable-inline-asm    # disable inline asm
  --disable-stripping     # disable stripping
  --disable-programs      # disable programs build (incl. ffplay, ffprobe & ffmpeg)
  --disable-doc           # disable doc
  --nm="llvm-nm"
  --ar=emar
  --ranlib=emranlib
  --cc=emcc
  --cxx=em++
  --objcc=emcc
  --dep-cc=emcc
  # 去掉不需要的库
  --disable-avdevice
  --disable-swresample
  --disable-postproc
  --disable-network
  --disable-pthreads
  --disable-w32threads
  --disable-os2threads
  # 配置需要的解封装，编解码器等
  --disable-everything # 减少wasm体积的关键，除了以下的组件外的个别组件都disable
  --enable-filters
  --enable-muxer=image2
  --enable-demuxer=mov # mov,mp4,m4a,3gp,3g2,mj2
  --enable-demuxer=flv
  --enable-demuxer=h264
  --enable-demuxer=asf
  --enable-encoder=mjpeg
  --enable-decoder=hevc
  --enable-decoder=h264
  --enable-decoder=mpeg4
  --enable-protocol=file
)
echo "FFMPEG_CONFIG_FLAGS=${FLAGS[@]}"
emconfigure ./configure "${FLAGS[@]}"

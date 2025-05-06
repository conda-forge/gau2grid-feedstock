if [[ "$target_platform" == osx-* ]]; then
    ARCH_ARGS=""
    ALLOPTS="${CFLAGS}"
fi
if [[ "$target_platform" == linux-* ]]; then
    ARCH_ARGS=""
    # revisit when c-f moves to gcc8
    # * checked Dec 2020 at gcc9 and define still needed
    ALLOPTS="${CFLAGS} -D__GG_NO_PRAGMA"
fi

cmake ${CMAKE_ARGS} ${ARCH_ARGS} \
    -S ${SRC_DIR} \
    -B build \
    -G Ninja \
    -D CMAKE_INSTALL_PREFIX=${PREFIX} \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_C_COMPILER=${CC} \
    -D CMAKE_C_FLAGS="${ALLOPTS}" \
    -D CMAKE_INSTALL_LIBDIR=lib \
    -D INSTALL_PYMOD=OFF \
    -D BUILD_SHARED_LIBS=ON \
    -D ENABLE_XHOST=OFF \
    -D PYTHON_EXECUTABLE=${BUILD_PREFIX}/bin/python \
    -D MAX_AM=8

cmake --build build --target install


# tests outside build phase

# when pygau2grid returns
# *    -DPYMOD_INSTALL_LIBDIR="/python${PY_VER}/site-packages" \
# *    -DPYTHON_EXECUTABLE=${PYTHON} \

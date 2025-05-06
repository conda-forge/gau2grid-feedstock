cmake %CMAKE_ARGS% ^
  -S %SRC_DIR% ^
  -B build ^
  -G "Ninja" ^
  -D CMAKE_BUILD_TYPE=Release ^
  -D CMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
  -D CMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
  -D CMAKE_INSTALL_LIBDIR="%LIBRARY_LIB%" ^
  -D CMAKE_INSTALL_INCLUDEDIR="%LIBRARY_INC%" ^
  -D CMAKE_INSTALL_BINDIR="%LIBRARY_BIN%" ^
  -D CMAKE_INSTALL_DATADIR="%LIBRARY_PREFIX%" ^
  -D INSTALL_PYMOD=OFF ^
  -D CMAKE_C_FLAGS="/wd4018 /wd4101 /wd4996" ^
  -D CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
  -D BUILD_SHARED_LIBS=ON ^
  -D ENABLE_GENERIC=ON ^
  -D PYTHON_EXECUTABLE=%BUILD_PREFIX%/python.exe ^
  -D MAX_AM=8
if errorlevel 1 exit 1

cd build
cmake --build . ^
      --config Release ^
      --target install ^
      -- -j %CPU_COUNT%
if errorlevel 1 exit 1

:: tests outside build phase

:: When pygau2grid returns
::      -DPYMOD_INSTALL_LIBDIR="/../../Lib/site-packages" ^
::      -DPYTHON_EXECUTABLE=%PYTHON% ^
 
:: Perils
:: %BUILD_PREFIX%/bin/cmake ^  # deadly on c-f
:: -DCMAKE_C_FLAGS="/wd4018 /wd4101 /wd4996 %CFLAGS%" ^  # error MSB3073
::cmake -G "%CMAKE_GENERATOR%" ^  # appveyor only


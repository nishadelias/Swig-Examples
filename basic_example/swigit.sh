#!/bin/bash

printf "This script wraps the cointoss.cpp file to have a python interface through swig\nModify the contents of this file judiciously\n"

FILE_NAME="cointoss"
SWIG_FILE=${FILE_NAME}.i
C_FILE=${FILE_NAME}.cpp
INC_FILE=${FILE_NAME}.h

INC_PYTHON="-I/Library/Frameworks/Python.framework/Versions/3.12/include/python3.12"
LIB_PYTHON="-L/Library/Frameworks/Python.framework/Versions/3.12/lib/python3.12/config-3.12-darwin -ldl -framework CoreFoundation -lpython3.12"

# Clean up previous output files
rm -f _${FILE_NAME}.so
rm -f ${FILE_NAME}_wrap.cxx
rm -f ${FILE_NAME}_wrap.o
rm -f ${FILE_NAME}.py
rm -rf __pycache__

echo "All temp files / libraries initially deleted"
echo "Creating new temp files / libraries..."

# Generate wrapper code with SWIG
swig -c++ -python ${SWIG_FILE}
if [ $? -ne 0 ]; then
    echo "[ERROR:] swig -c++ -python ${SWIG_FILE} command returned with failure!"
    exit 1
fi

# Compile the wrapper code and the C++ source code
g++ -O3 -fpic -c ${FILE_NAME}_wrap.cxx ${C_FILE} $INC_PYTHON
if [ $? -ne 0 ]; then
    echo "[ERROR:] g++ -fpic -c ${FILE_NAME}_wrap.cxx ${C_FILE} $INC_PYTHON command returned with failure!"
    exit 1
fi

# Create a shared library from the object files
g++ $LIB_PYTHON -dynamiclib ${FILE_NAME}_wrap.o ${FILE_NAME}.o -o _${FILE_NAME}.so
if [ $? -ne 0 ]; then
    echo "[ERROR:] g++ -dynamiclib ${FILE_NAME}_wrap.o ${FILE_NAME}.o -o _${FILE_NAME}.so command returned with failure!"
    exit 1
fi

printf "All temp files / libraries (re)created!\nModule ${FILE_NAME}.py is now ready for use!\n"
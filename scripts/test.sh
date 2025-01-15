#!/bin/sh

BINARIES="exiftool chromium soffice pdfcpu pdftk qpdf"
for BINARY in $BINARIES
do
    if ! command -v "$BINARY" >/dev/null 2>&1
    then
        echo "Error: $BINARY is not installed or not in PATH." >&2;
        exit 1
    fi
done

export EXIFTOOL_BIN_PATH=$(command -v exiftool)
export CHROMIUM_BIN_PATH=$(command -v chromium)
export PDFCPU_BIN_PATH=$(command -v pdfcpu)
export PDFTK_BIN_PATH=$(command -v pdftk)
export QPDF_BIN_PATH=$(command -v qpdf)
export LIBREOFFICE_BIN_PATH=$(command -v soffice)
export UNOCONVERTER_BIN_PATH=$LIBREOFFICE_BIN_PATH

echo Executing gotenberg tests...
go test -race -covermode=atomic ./...

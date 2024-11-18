#!/bin/sh

check_binary() {
    command -v "$1" >/dev/null 2>&1 || { echo "Error: $1 is not installed or not in PATH." >&2; exit 1; }
}

BINARIES="exiftool chromium soffice pdfcpu pdftk qpdf"
for BINARY in $BINARIES; do
    check_binary "$BINARY"
done

export EXIFTOOL_BIN_PATH=$(command -v exiftool)
export CHROMIUM_BIN_PATH=$(command -v chromium)
export LIBREOFFICE_BIN_PATH=$(command -v soffice)
export UNOCONVERTER_BIN_PATH=$LIBREOFFICE_BIN_PATH
export PDFCPU_BIN_PATH=$(command -v pdfcpu)
export PDFTK_BIN_PATH=$(command -v pdftk)
export QPDF_BIN_PATH=$(command -v qpdf)

for VAR in EXIFTOOL_BIN_PATH CHROMIUM_BIN_PATH LIBREOFFICE_BIN_PATH UNOCONVERTER_BIN_PATH PDFCPU_BIN_PATH PDFTK_BIN_PATH QPDF_BIN_PATH; do
    [ -n "${!VAR}" ] || { echo "Error: $VAR is not set." >&2; exit 1; }
done

export PORT=${PORT:-49153}

if [ "$1" = "--build" ]; then
    echo "Building Gotenberg..."
    go build -o gotenberg ./cmd/gotenberg || { echo "Build failed." >&2; exit 1; }
    shift
fi

exec ./gotenberg --api-port="${PORT}" "$@"

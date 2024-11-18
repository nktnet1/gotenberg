#!/bin/sh

GOTENBERG_URL="http://localhost:49153/forms/chromium/convert/url"
DEFAULT_PDF_URL="https://sparksuite.github.io/simple-html-invoice-template"
PDF_URL="${1:-$DEFAULT_PDF_URL}"

curl \
  --request POST "${GOTENBERG_URL}" \
  --form url="${PDF_URL}" \
  --form preferCssPageSize=true \
  --form generateDocumentOutline=true \
  --form printBackground=true \
  -o output/example.pdf

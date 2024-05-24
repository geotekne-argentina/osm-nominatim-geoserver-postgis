#!/bin/sh
# script credits to: https://github.com/LanceMcDermott
set -e

FONTDIR="./fonts"

mkdir -p "${FONTDIR}"

# download filename url
download() {
  ## Download if newer, and if curl fails, clean up and exit
  curl --fail --compressed -A "get-fonts.sh/osm-carto" -o "$1" -z "$1" -L "$2" || { echo "Failed to download $1 $2"; rm -f "$1"; exit 1; }
}

# TTF Hinted Noto Fonts

# Fonts available in regular, bold, and italic
REGULAR_BOLD_ITALIC="NotoSans"

# Fonts available in regular and bold
REGULAR_BOLD="NotoSansUI"

# Fonts only available in regular
REGULAR="NotoSans"

# Download the fonts in the lists above
for font in $REGULAR_BOLD_ITALIC; do
  regular="$font-Regular.ttf"
  bold="$font-Bold.ttf"
  italic="$font-Italic.ttf"
  download "${FONTDIR}/${regular}" "https://github.com/notofonts/noto-fonts/raw/main/hinted/ttf/${font}/${regular}"
  download "${FONTDIR}/${bold}" "https://github.com/notofonts/noto-fonts/raw/main/hinted/ttf/${font}/${bold}"
  download "${FONTDIR}/${italic}" "https://github.com/notofonts/noto-fonts/raw/main/hinted/ttf/${font}/${italic}"
done

for font in $REGULAR_BOLD; do
  regular="$font-Regular.ttf"
  bold="$font-Bold.ttf"
  download "${FONTDIR}/${regular}" "https://github.com/notofonts/noto-fonts/raw/main/hinted/ttf/${font}/${regular}"
  download "${FONTDIR}/${bold}" "https://github.com/notofonts/noto-fonts/raw/main/hinted/ttf/${font}/${bold}"
done

for font in $REGULAR; do
  regular="$font-Regular.ttf"
  download "${FONTDIR}/${regular}" "https://github.com/notofonts/noto-fonts/raw/main/hinted/ttf/${font}/${regular}"
done

# Fonts in zipfiles need a temporary directory
TMPDIR=$(mktemp -d -t get-fonts.XXXXXXXXX)
trap "rm -rf ${TMPDIR} ${FONTDIR}/static" EXIT

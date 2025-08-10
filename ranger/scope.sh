#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

FILE_PATH="${1}"
PV_WIDTH="${2:-80}"
PV_HEIGHT="${3:-24}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5:-False}"

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

# Handle different file types
handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        ## Archive
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "${FILE_PATH}" && exit 5
            bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;
        
        ## Text/Code files (ADD THIS SECTION)
        js|jsx|ts|tsx|json|html|htm|css|scss|sass|less|vue|py|rb|go|rs|c|cpp|h|hpp|\
        java|php|sh|bash|zsh|fish|vim|lua|sql|yaml|yml|toml|ini|conf|config|\
        txt|md|markdown|rst|org|tex|log|xml|svg)
            # Syntax highlight if available
            if command -v highlight >/dev/null 2>&1; then
                highlight --replace-tabs=8 --out-format=ansi --style=pablo --force -- "${FILE_PATH}" && exit 5
            elif command -v bat >/dev/null 2>&1; then
                bat --style=numbers --color=always --pager=never -- "${FILE_PATH}" && exit 5
            fi
            # Fallback to cat
            cat "${FILE_PATH}" && exit 5
            exit 2;;
        
        ## PDF
        pdf)
            # Try to extract text
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
                fmt -w "${PV_WIDTH}" && exit 5
            # Fallback to image preview
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                pdftoppm -f 1 -l 1 -scale-to-x 1920 -scale-to-y -1 -singlefile -jpeg -tiffcompression jpeg -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" && \
                exit 6
            exit 1;;
        
        ## Video
        avi|mp4|wmv|dat|3gp|ogv|mkv|mpg|mpeg|vob|fl[icv]|m2v|mov|webm|ts|mts|m4v|r[am]|qt|divx|as[fx])
            # Thumbnail for video
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && \
                exit 6
            # Fallback to mediainfo
            mediainfo "${FILE_PATH}" && exit 5
            exit 1;;
        
        ## Audio
        aac|flac|m4a|mid|midi|mpa|mp2|mp3|ogg|wav|wma|wv|opus)
            mediainfo "${FILE_PATH}" && exit 5
            exit 1;;
        
        ## Image
        bmp|jpg|jpeg|png|gif|webp|tiff|tif|ico)
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                exit 6  # Let ranger handle image display
            # Fallback to image info
            identify "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        ## Text
        text/* | */xml | application/javascript | application/json)
            # Syntax highlight
            if command -v highlight >/dev/null 2>&1; then
                highlight --replace-tabs=8 --out-format=ansi --style=pablo --force -- "${FILE_PATH}" && exit 5
            elif command -v bat >/dev/null 2>&1; then
                bat --style=numbers --color=always --pager=never -- "${FILE_PATH}" && exit 5
            fi
            # Fallback to cat
            cat "${FILE_PATH}" && exit 5
            exit 2;;
        
        ## Image
        image/*)
            [ "$PV_IMAGE_ENABLED" = 'True' ] && exit 6
            identify "${FILE_PATH}" && exit 5
            exit 1;;
        
        ## Video
        video/*)
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && \
                exit 6
            mediainfo "${FILE_PATH}" && exit 5
            exit 1;;
        
        ## PDF
        application/pdf)
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
                fmt -w "${PV_WIDTH}" && exit 5
            exit 1;;
    esac
}

# Get MIME type
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"

# Try extension first, then MIME type
handle_extension
handle_mime "${MIMETYPE}"

# Fallback
echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
exit 1

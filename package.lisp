;;;; package.lisp 
;;
;; Copyright (c) 2018 Jeremiah LaRocco <jeremiah_larocco@fastmail.com>


;; Permission to use, copy, modify, and/or distribute this software for any
;; purpose with or without fee is hereby granted, provided that the above
;; copyright notice and this permission notice appear in all copies.

;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

(defpackage :zbar
  (:use #:cl #:cffi #:j-utils #:alexandria)
  (:export

   #:version
   #:set-verbosity
   #:increase-verbosity
   #:error-string
   #:get-error-code
   
   #:get-symbol-name
   #:get-addon-name
   
   #:image-create
   #:image-destroy
   #:image-convert
   #:image-convert-resize

   #:image-get-format
   #:image-get-sequence
   #:image-get-width
   #:image-get-height
   #:image-get-data
   #:image-get-data-length
   #:image-get-symbols
   #:image-set-symbols
   #:image-first-symbol

   #:image-set-format
   #:image-set-sequence
   #:image-get-size
   #:image-set-data
   #:image-free-data
   #:image-write
   #:image-read

   #:image-scanner-create
   #:image-scanner-destroy
   #:image-scanner-set-data-handler
   #:image-scanner-set-config
   #:image-scanner-parse-config
   #:image-scanner-enable-cache
   #:image-scanner-recycle-image
   #:image-scanner-get-results
   #:scan-image

   #:zbar-ok
   #:zbar-err-nomem
   #:zbar-err-internal
   #:zbar-err-unsupported
   #:zbar-err-invalid
   #:zbar-err-system
   #:zbar-err-locking
   #:zbar-err-busy
   #:zbar-err-xdisplay
   #:zbar-err-xproto
   #:zbar-err-closed
   #:zbar-err-winapi
   #:zbar-err-num
   
   #:zbar-none
   #:zbar-partial
   #:zbar-ean8
   #:zbar-upce
   #:zbar-isbn10
   #:zbar-upca
   #:zbar-ean13
   #:zbar-isbn13
   #:zbar-i25
   #:zbar-code39
   #:zbar-pdf417
   #:zbar-qrcode
   #:zbar-code128
   #:zbar-symbol
   #:zbar-addon2
   #:zbar-addon5
   #:zbar-addon

   ;; Symbol interface
   #:symbol-get-type
   #:symbol-get-data
   #:symbol-get-data-length
   #:symbol-get-quality
   #:symbol-get-loc-size
   #:symbol-get-loc-x
   #:symbol-get-loc-y
   #:symbol-next
   #:symbol-get-components
   #:symbol-first-component

   #:symbol-set-get-size
   #:symbol-set-first-symbol

   #:simple-scan

   #:scan-cv-image
   ))

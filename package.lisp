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
  (:export #:image-create
           #:image-destroy
           #:image-set-format
           #:image-get-format
           #:image-set-size
           #:image-set-data
           #:scan-image

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

           #:image-first-symbol
           #:symbol-next
           #:symbol-get-type
           #:get-symbol-name
           #:symbol-next))

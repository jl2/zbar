;;;; symbol.lisp 
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

(in-package :zbar)


(cffi:defcenum :zbar-symbol-type-t
    (:zbar-none              0)
    (:zbar-partial           1)
    (:zbar-ean8              8)
    (:zbar-upce              9)
    (:zbar-isbn10           10)
    (:zbar-upca             12)
    (:zbar-ean13            13)
    (:zbar-isbn13           14)
    (:zbar-i25              25)
    (:zbar-code39           39)
    (:zbar-pdf417           57)
    (:zbar-qrcode           64)
    (:zbar-code128         128)
    (:zbar-symbol       #x00ff)
    (:zbar-addon2       #x0200)
    (:zbar-addon5       #x0500)
    (:zbar-addon        #x0700e))

(define-cfun ("zbar_image_first_symbol" image-first-symbol) :pointer
  (image :pointer))

(define-cfun ("zbar_symbol_next" symbol-next) :pointer
  (symbol :pointer))


(define-cfun ("zbar_symbol_get_type" symbol-get-type) :zbar-symbol-type-t
  (symbol :pointer))

(define-cfun ("zbar_symbol_get_data" symbol-get-type) :string
  (symbol :pointer))


(define-cfun ("zbar_get_symbol_name" get-symbol-name) :string
  (symbol :pointer))

(define-cfun ("zbar_symbol_next" symbol-next) :pointer
  (symbol :pointer))

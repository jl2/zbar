;;;; image-scanner.lisp 
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

(define-cfun ("zbar_image_scanner_create" image-scanner-create) :pointer)
(define-cfun ("zbar_image_scanner_destroy" image-scanner-destroy) :void
  (scanner :pointer))


(define-cfun ("zbar_image_scanner_set_data_handler" image-scanner-set-data-handler) :pointer
  (scanner :pointer)
  (handler :pointer)
  (userdata :pointer))

(define-cfun ("zbar_image_scanner_set_config" image-scanner-set-config) :int
  (scanner :pointer)
  (symbology :zbar-symbol-type-t)
  (config :zbar-config-t)
  (value :int))

(define-cfun ("zbar_image_scanner_parse_config" image-scanner-parse-config) :int
  (scanner :pointer)
  (config-string :string))

(define-cfun ("zbar_image_scanner_enable_cache" image-scanner-enable-cache) :void
  (scanner :pointer)
  (enable :int))

(define-cfun ("zbar_image_scanner_recycle_image" image-scanner-recycle-image) :void
  (scanner :pointer)
  (image :pointer))

(define-cfun ("zbar_image_scanner_get_results" image-scanner-get-results) :pointer
  (scanner :pointer))

(define-cfun ("zbar_scan_image" scan-image) :int
  (scanner :pointer)
  (image :pointer))

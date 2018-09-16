;;;; image.lisp 
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

(define-cfun ("zbar_image_create" image-create) :pointer)

(define-cfun ("zbar_image_destroy" image-destroy) :void
  (image :pointer))

(define-cfun ("zbar_image_set_format" image-set-format) :void
  (image :pointer)
  (format :unsigned-long))

(define-cfun ("zbar_image_get_format" image-get-format) :unsigned-long
  (image :pointer))


(define-cfun ("zbar_image_set_size" image-set-size) :void
  (image :pointer)
  (width :unsigned-int) 
 (height :unsigned-int))

(define-cfun ("zbar_image_set_data" image-set-data) :void
  (image :pointer)
  (data :pointer)
  (data-byte-length :unsigned-long)
  (cleanup-handler :pointer))

(define-cfun ("zbar_scan_image" scan-image) :int
  (scanner :pointer)
  (image :pointer))


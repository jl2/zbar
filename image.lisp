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

(define-cfun ("zbar_image_convert" z-image-convert) :pointer
  (image :pointer)
  (format :unsigned-long))

(defun image-convert (image format)
  (z-image-convert image (from-four-cc format)))

(define-cfun ("zbar_image_convert_resize" z-image-convert-resize) :pointer
  (image :pointer)
  (format :unsigned-long)
  (width :unsigned-int)
  (height :unsigned-int))

(defun image-convert-resize (image format width height)
  (z-image-convert-resize image (from-four-cc format) width height))

(define-cfun ("zbar_image_get_format" z-image-get-format) :unsigned-long
  (image :pointer))

(defun image-get-format (image)
  (to-four-cc (z-image-get-format image)))

(define-cfun ("zbar_image_get_sequence" image-get-sequence) :unsigned-int
  (image :pointer))

(define-cfun ("zbar_image_get_width" image-get-width) :unsigned-int
  (image :pointer))

(define-cfun ("zbar_image_get_height" image-get-height) :unsigned-int
  (image :pointer))

(define-cfun ("zbar_image_get_data" image-get-data) :pointer
  (image :pointer))

(define-cfun ("zbar_image_get_data_length" image-get-data-length) :unsigned-long
  (image :pointer))

(define-cfun ("zbar_image_get_symbols" image-get-symbols) :pointer
  (image :pointer))

(define-cfun ("zbar_image_set_symbols" image-set-symbols) :pointer
  (image :pointer)
  (symbols :pointer))

(define-cfun ("zbar_image_set_format" z-image-set-format) :void
  (image :pointer)
  (format :unsigned-long))

(defun image-set-format (image format)
  (z-image-set-format image (from-four-cc format)))

(define-cfun ("zbar_image_set_sequence" image-set-sequence) :void
  (image :pointer)
  (sequence-num :unsigned-long))

(define-cfun ("zbar_image_set_size" image-set-size) :void
  (image :pointer)
  (width :unsigned-int) 
 (height :unsigned-int))

(define-cfun ("zbar_image_free_data" z-image-free-data) :void
  (image :pointer))

(defcallback image-free-data :void
    ((image :pointer))
  (z-image-free-data image))

(define-cfun ("zbar_image_set_data" image-set-data) :void
  (image :pointer)
  (data :pointer)
  (data-byte-length :unsigned-long)
  (cleanup-handler :pointer (cffi:get-callback 'image-free-data)))


(define-cfun ("zbar_image_write" image-write) :int
  (image :pointer)
  (filebase :string))

(define-cfun ("zbar_image_read" image-read) :pointer
  (filename :string))



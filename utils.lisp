;;;; utils.lisp 
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

(defun filter-image (img)
  "Apply a filter that enhances the lines in a bar code."
  (let ((filtered (cv:create-image (cv:get-size img) 8 1))
        (kernel (cv:create-mat 5 5 cv:+32FC1+))
        (mat #2A(( 0.0 0.0 0.0 0.0 0.0)
                 ( 0.0 1.0 2.0 1.0 0.0)
                 ( 0.2 0.0 1.0 0.0 0.2)
                 ( 0.0 -1.0 -2.0 -1.0 -0.0)
                 ( 0.0 0.0 0.0 0.0 0.0))))
    (cv:cvt-color img filtered cv:+rgb-2-gray+)
    (unwind-protect
         ;; TODO: Since only a few scanlines are used, don't filter the entire image.
         (progn
           (dotimes (i 5)
             (dotimes (j 5)
               (cv:set-2d kernel i j (cv:scalar (aref mat j i)))))
           (cv:filter-2d filtered filtered kernel))
      (cv:free kernel))
    filtered))

(defun simple-scan (file-name)
  (let* ((cvimage (cv:load-image file-name))
         (filtered (filter-image cvimage))
         (size (cv:get-size cvimage))
         (scanner (image-scanner-create))
         (image (image-create)))
    (image-scanner-set-config scanner :zbar-isbn13 :zbar-cfg-enable 1)
    ;;(format t "Error: ~a~%" (error-string scanner 10))
    (image-set-size image (cv:ipl-width-step filtered) (cv:ipl-height filtered))
    (image-set-data image (cv:ipl-data filtered) (* (cv:ipl-width-step filtered) (cv:ipl-height filtered)) (cffi:null-pointer))
    (image-set-format image "GRAY")

    (let ((result (scan-image scanner image)))
      (format t "result: ~a~%" result)
      (when (< result 0)
        (format t "Error string: ~a~%" (error-string scanner 127))
        (format t "Error string: ~a~%" (error-string image 127))))

    (cv:release-image filtered)
    (cv:release-image cvimage)
    (image-scanner-destroy scanner)
    (image-destroy image)
    nil))
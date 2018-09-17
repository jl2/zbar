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

(defun scan-cv-image (cv-image)
  (let* ((filtered (filter-image cv-image))
         (scanner (image-scanner-create))
         (image (image-create))
         (rval nil))

    (image-scanner-set-config scanner 0 :zbar-cfg-enable 1)
    ;;(format t "Error: ~a~%" (error-string scanner 10))
    (image-set-size image (cv:ipl-width-step filtered) (cv:ipl-height filtered))
    (image-set-data image (cv:ipl-data filtered) (* (cv:ipl-width-step filtered) (cv:ipl-height filtered)) (cffi:null-pointer))
    (image-set-format image "Y800")

    (let ((result (scan-image scanner image)))
      (when (> result 0)
        (do ((symbol (zbar:image-first-symbol image)
                     (zbar:symbol-next symbol)))
            ((cffi:null-pointer-p symbol))
          (format t "Found symbol: ~a~%   Data: ~a~%" (zbar:symbol-get-type symbol) (zbar:symbol-get-data symbol))
          (push (cons (zbar:symbol-get-type symbol) (zbar:symbol-get-data symbol)) rval)))
      (cv:release-image filtered)
      (image-scanner-destroy scanner)
      (image-destroy image)
      rval)))

(defun simple-scan (file-name)
  (let* ((cvimage (cv:load-image file-name))
         (isbn (scan-cv-image cvimage)))
    (cv:release-image cvimage)
    isbn))

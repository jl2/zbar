;;;; zbar.lisp 
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

(defmacro define-cfun ((c-name name) return-type &body body)
  `(progn
     (defun ,name ,(loop for p in body
			 with optional = nil
			 with a = () with b = ()
			 do (if (= (length p) 2) (progn
						   (when optional (error "why not optional?"))
						   (push (car p) a))
			      (progn
				(setf optional t)
				(push (list (car p) (third p)) b)))
			 finally (return (append (reverse a) (cons '&optional (reverse b)))))
       (cffi:foreign-funcall
	,c-name
	,@(mapcan
	   #'(lambda (p)
	       (destructuring-bind (var type &rest r)
		   p
		 (declare (ignore r))
		 (list type (case type
			      (:float `(coerce ,var 'single-float))
			      (:double `(coerce ,var 'double-float))
			      (:int `(floor ,var))
			      (otherwise var)))))
	   body)
	,return-type))
     (export ',name)))

(defun hello ()
  (error "Not implemented"))

(define-cfun ("zbar_version" zbar-version) :int
  (major :pointer)
  (minor :pointer))

(defun version ()
  (with-foreign-objects ((major :unsigned-int 1)
                         (minor :unsigned-int 1))
    (let ((rval (zbar-version major minor)))
      (values rval (cffi:mem-ref major :unsigned-int) (cffi:mem-ref minor :unsigned-int)))))

(define-cfun ("zbar_set_verbosity" set-verbosity) :void
  (verbosity :int))

(cffi:defcenum  :zbar-error-t
    :zbar-ok
    :zbar-err-nomem
    :zbar-err-internal
    :zbar-err-unsupported
    :zbar-err-invalid
    :zbar-err-system
    :zbar-err-locking
    :zbar-err-busy
    :zbar-err-xdisplay
    :zbar-err-xproto
    :zbar-err-closed
    :zbar-err-winapi
    :zbar-err-num)

(cffi:defcenum :zbar-config
    (:zbar-cfg-enable 0)
    :zbar-cfg-add-check
    :zbar-cfg-emit-check
    :zbar-cfg-ascii
    :zbar-cfg-num

    (:zbar-cfg-min-len #x20)
    :zbar-cfg-max-len

    (:zbar-cfg-position #x80)

    (:zbar-cfg-x-density #x100)
    :zbar-cfg-y-density)

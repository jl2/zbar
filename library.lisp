(cffi:define-foreign-library zbar
  (:darwin "libzbar.dylib")
  (:linux "libzbar.so"))

(cffi:use-foreign-library zbar)

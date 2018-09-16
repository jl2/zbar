(cffi:define-foreign-library zbar-lib
  (:darwin "libzbar.dylib")
  (:linux "libzbar.so"))

(cffi:use-foreign-library zbar-lib)

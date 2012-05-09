(TeX-add-style-hook "cpcommon"
 (lambda ()
    (LaTeX-add-environments
     "changemargin"
     '("cpafootnote" 2))
    (TeX-add-symbols
     '("runinhead" 1)
     "cpahfamily"
     "cpahbig"
     "cpastretch"
     "cite")
    (TeX-run-style-hooks
     "titlesec"
     "tiny"
     "sf"
     "settobox"
     "hanging"
     "natbib"
     "ragged2e"
     "printlen"
     "calc"
     "setspace"
     "geometry"
     "letterpaper"
     "ellipsis"
     "xspace"
     "microtype"
     "graphicx"
     "amsthm"
     "amsmath"
     "amssymb"
     "hyperref"
     "xkeyval")))


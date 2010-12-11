(TeX-add-style-hook "cparticle"
 (lambda ()
    (LaTeX-add-environments
     "changemargin"
     '("cpafootnote" 2))
    (TeX-add-symbols
     '("runinhead" 1)
     "cpastretch"
     "cite")
    (TeX-run-style-hooks
     "titlesec"
     "tiny"
     "sf"
     "settobox"
     "hanging"
     "natbib"
     "printlen"
     "calc"
     "setspace"
     "geometry"
     "letterpaper"
     "unicode-math"
     "fontspec"
     "amsthm"
     "amsmath"
     "amssymb"
     "hyperref"
     "xkeyval")))


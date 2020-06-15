gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH \
-dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf `cat files | tr '\n' ' '`


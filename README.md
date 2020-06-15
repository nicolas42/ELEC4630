combine pdf documents using ghost script
souce: https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf input.pdf



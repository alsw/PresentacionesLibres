#Archivos que se agregan al comprimido
adicionales = Guia.md  

#Programa convertidor de sozi a pdf
sozi2pdf = python ../sozi2pdf/sozi2pdf.py

#Los archivos fuente son todos los .svg en el directorio actual
fuentes = $(shell find -name \*.svg)
#Los objetivos (pdf) son generados sustituyendo .svg por .pdf en los fuentes
objetivos = $(patsubst %.svg,%.pdf,$(fuentes))

#Obtiene la ruta de este makefile, independientemente de donde se invoque
ruta := $(abspath $(lastword $(MAKEFILE_LIST)))
#Obtiene el nombre del directorio actual
directorio := $(notdir $(patsubst %/,%,$(dir $(ruta))))
#Determina el nombre del archivo comprimido agregando la extension .zip al
#directorio actual
comprimido = ../Comprimidos/$(directorio).zip

$(comprimido): $(objetivos) $(fuentes) $(adicionales)
	zip $@ $^
		
%.pdf: %.svg
	$(sozi2pdf) $<

.phony: clean
clean:
	rm -f $(comprimido)
	rm -f $(objetivos)

.phony: pdfmenos
pdfmenos:
	rm -f $(objetivos)

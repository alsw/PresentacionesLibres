comprimir:
	(cd Git; make)
	(cd OHSV; make)
	(cd Mini-Presentaciones-Salvajes/Rss; make)

.phony: clean
clean:
	(cd Git; make clean)
	(cd OHSV; make clean)
	(cd Mini-Presentaciones-Salvajes/Rss;  make clean)

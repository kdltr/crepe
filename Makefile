play: crepe
	./crepe

crepe: cairo-utils.so crepe.scm logic.scm
	csc crepe.scm

cairo-utils.so: cairo-utils.scm
	csc -sJ cairo-utils.scm

clean:
	rm -f *.import.scm *.so crepe

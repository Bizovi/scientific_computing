MODULES = mod_diff.f90 mod_initial.f90


tsunami: 
	gfortran $(MODULES) tsunami.f90 -o build/tsunami

run: 
	./build/tsunami > data/tsunami_out.txt

all: tsunami run

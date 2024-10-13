
libname = ode
FC = gfortran
major = 1
minor = 0
release = 0
version = $(major).$(minor).$(release)

LIB = $(HOME)/Fortran/lib
INC = $(HOME)/Fortran/include

.PHONY : install compile all test

all : install compile 

compile : 
	$(FC) -O3 -fpic -c -J $(HOME)/Fortran/include $(libname).f90
	$(FC) -shared -o $(HOME)/Fortran/lib/lib$(libname).so.$(version) $(libname).o
	rm *.o
	ln -s $(HOME)/Fortran/lib/lib$(libname).so.$(version) $(HOME)/Fortran/lib/lib$(libname).so.$(major)
	ln -s $(HOME)/Fortran/lib/lib$(libname).so.$(major) $(HOME)/Fortran/lib/lib$(libname).so

install:
	./install.sh

test:
	@$(FC) -I$(INC) test.f90 -L$(LIB) -lode
	@LD_LIBRARY_PATH=$(LIB) ./a.out


readme:
	pandoc -f gfm README.md -o README.pdf

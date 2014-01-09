# Compiler
FC = gfortran
# flags for debugging or for maximum performance:
FCFLAGS = -g -fbounds-check
#FCFLAGS = -O2
# flags forall (e.g. look for system .mod files, required in gfortran)
#FCFLAGS += -I./

# libraries for linking
# LDFLAGS = -llibrary

# list of executables to be built
PROGRAMS = main

# "make" builds all
all: $(PROGRAMS)

main.o: main.f90 m_data.o m_init.o m_io.o m_compute.o m_copy.o m_allocate.o
main: m_data.o m_init.o m_io.o m_compute.o m_copy.o m_allocate.o

m_init.o: m_init.f90 m_data.o m_allocate.o

m_io.o: m_io.f90 m_data.o

m_compute.o:  m_compute.f90 m_copy.o m_data.o
# executables
%: %.o
	$(FC) $(FCFLAGS) -o $@ $^ $(LDFLAGS)

# object files
%.o: %.f90
	$(FC) $(FCFLAGS) -c $<

%.o: %.F90
	$(FC) $(FCFLAGS) -c $<

# Utility targets
.PHONY: clean veryclean

clean:
	rm -f *.o *.mod *.MOD

veryclean: clean
	rm -f *~ $(PROGRAMS); rm -f *.dat

new: veryclean all

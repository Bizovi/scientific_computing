program hello
    implicit none           ! every type has to be declared
    print *, 'Hello world!'  ! * default output in a format compatible w/ types

    ! compile + link in one step: gfortran hello.f90 -o hello
    ! compile:      gfortran -c hello.f90
    ! link to exec: gfortran hello.o -o hello  
end program hello
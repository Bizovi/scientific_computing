program echo_robot

    use iso_fortran_env, only: stdin  => input_unit, &
                               stdout => output_unit, &
                               stderr => error_unit 
    implicit none
    character(1000) :: text
    integer :: a
    real :: x
    
    read  (stdin,  '(a)') text
    write (stdout, '(a)') trim(text)
    write (stderr, '(a)') 'A wild error message'
end program echo_robot
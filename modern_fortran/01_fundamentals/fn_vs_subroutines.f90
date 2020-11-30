program trivial_functions

    use iso_fortran_env, only: compiler_options, compiler_version, int32
    use mod_circle, only: circle_area
    implicit none
    integer(int32) :: a, n, total
    real :: radiuses(5)

    print *, 'Compiler version: ', compiler_version()
    print *, 'Compiler options: ', compiler_options()

    radiuses = [1.2, 4., 2., 10., 15.]
    print *, 'Circle area of : ', radiuses, 'is: ', circle_area(radiuses)

    a = 0
    do n = 1, 10
        call add(a, n)
    end do

    total = 2 * sum_(a, 5)
    print *, 'The total is ', total

contains
    ! if not using this sytax, the alternative is:
    ! declaring the result/return variable inside the function
    ! result() allows us to declare other name rather than the function name
    integer function sum_(a, b) result(sum)
        integer, intent(in) :: a, b  ! their value will not change in procedure
        sum = a + b
    end function sum_

    ! explore optional arguments
    subroutine add(a, b, debug)
        integer, intent(in out) :: a ! equivalent of void or None
        integer, intent(in) :: b
        logical, intent(in), optional :: debug

        if (present (debug)) then
            if (debug) then
                print *, 'DEBUG: subroutine add, a= ', a
                print *, 'DEBUG: subroutine add, b= ', b
            end if
        end if

        a = a + b
        print *, 'a=', a

        if (present (debug)) then
            if (debug) then
                print *, 'DEBUG: subroutine add, a= ', a
            end if
        end if
    end subroutine add
    
end program trivial_functions
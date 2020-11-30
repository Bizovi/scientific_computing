program trivial_functions
    implicit none
    integer :: a, n, total

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

    subroutine add(a, b)
        integer, intent(in out) :: a ! equivalent of void or None
        integer, intent(in) :: b

        a = a + b
        print *, 'a=', a
    end subroutine add
    
end program trivial_functions
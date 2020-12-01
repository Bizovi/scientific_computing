module mod_diff

    use iso_fortran_env, only: int32, real32
    implicit none
    public  :: diff_centered
    private :: diff_upwind

contains
    ! calculates the difference in space of a real-valued input vector
    ! hides the details of the implementation, e.g. the boundary condition
    pure function diff_upwind(x) result(dx)
        real(real32), intent(in) :: x(:)  ! : assumes the shape of the passed array
        real(real32)   :: dx(size(x))     ! same size as x
        integer(int32) :: im

        im = size(x)
        dx(1) = x(1) - x(im)            ! handle the boundary condition

        ! TODO(Mihai) <| need a centered difference
        ! water doesn't only flow from left to right
        dx(2:im) = x(2:im) - x(1:im-1)
    end function diff_upwind

    ! Assumes a window of two, calculating the average, moves in both directions
    pure function diff_centered(x) result(dx)
        real(real32), intent(in) :: x(:)
        real(real32)   :: dx(size(x))
        integer(int32) :: im
        im = size(x)

        dx(1)  = x(2) - x(im)   ! boundary on the left
        dx(im) = x(1) - x(im-1) ! boundary on the right
        dx(2:im-1) = x(3:im) - x(1:im-2)
        dx = 0.5 * dx
    end function diff_centered

end module mod_diff
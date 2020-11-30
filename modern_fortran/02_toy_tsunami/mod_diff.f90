module mod_diff

    use iso_fortran_env, only: int32, real32
    implicit none
    public :: diff

contains
    ! calculates the difference in space of a real-valued input vector
    ! hides the details of the implementation, e.g. the boundary condition
    pure function diff(x) result(dx)
        real(real32), intent(in) :: x(:)  ! : assumes the shape of the passed array
        real(real32)   :: dx(size(x))     ! same size as x
        integer(int32) :: im

        im = size(x)
        dx(1) = x(1) - x(im)            ! handle the boundary condition
        dx(2:im) = x(2:im) - x(1:im-1)  ! finite difference of other elements of x(:)
    end function diff

end module mod_diff
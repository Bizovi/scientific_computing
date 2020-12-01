module mod_arrays
    implicit none
    private
    public :: reverse, average, std, moving_average, moving_std, &
        crossneg, crosspos
    
contains
    pure function reverse(x)
        real, intent(in) :: x(:)
        real :: reverse(size(x))
        reverse = x(size(x):1:-1)
    end function reverse

    pure real function average(x)
        real, intent(in) :: x(:)
        average = sum(x) / size(x)
    end function average

    pure real function std(x)
        real, intent(in) :: x(:)
        std = sqrt(average((x - average(x)) ** 2))
    end function std

    pure function moving_average(x, w) result(res)
        real, intent(in) :: x(:)
        integer, intent(in) :: w
        real :: res(size(x))

        integer :: i, i1
        do i = i, size(x)
            i1 = max(i-w, 1)
            res(i) = average(x(i1:i))
        end do
    end function moving_average

    pure function moving_std(x, w) result(res)
        ! Returns the moving standard deviation of x with one-sided window w.
        real, intent(in) :: x(:)
        integer, intent(in) :: w
        real :: res(size(x))
        integer :: i, i1
        do i = 1, size(x)
            i1 = max(i-w, 1)
            res(i) = std(x(i1:i))
        end do 
    end function moving_std

    pure function crosspos(x, w) result(res)
        ! Returns indices where input array x crosses its
        ! moving average with window w from negative to positive.
        real, intent(in) :: x(:)
        integer, intent(in) :: w
        integer, allocatable :: res(:)
        real, allocatable :: xavg(:)
        logical, allocatable :: greater(:), smaller(:)
        integer :: i

        res = [(i, i = 2, size(x))]
        xavg = moving_average(x, w)
        greater = x > xavg
        smaller = x < xavg
        res = pack(res, greater(2:) .and. smaller(:size(x)-1))
    end function crosspos

    pure function crossneg(x, w) result(res)
        ! Returns indices where input array x crosses its
        ! moving average with window w from positive to negative.
        real, intent(in) :: x(:)
        integer, intent(in) :: w
        integer, allocatable :: res(:)
        real, allocatable :: xavg(:)
        logical, allocatable :: greater(:), smaller(:)
        integer :: i
        
        res = [(i, i = 2, size(x))]
        xavg = moving_average(x, w)
        greater = x > xavg
        smaller = x < xavg
        res = pack(res, smaller(2:) .and. greater(:size(x)-1))
    end function crossneg
end module mod_arrays
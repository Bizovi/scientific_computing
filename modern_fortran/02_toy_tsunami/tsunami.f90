program tsunami
    implicit none

    ! ========= Declare vars and constants =======
    ! ============================================
    integer, parameter :: grid_size = 100           ! constant, same line required init.
    integer, parameter :: num_time_steps = 100      ! simulation length
    real,    parameter :: dt = 1., dx = 1., c = 1.  ! time step, grid step, bg flow speed
    integer, parameter :: icenter = 25              ! mean of gaussian / central index
    real,    parameter :: decay = 0.02              ! shape factor (1/sigma)

    integer :: n          ! n - time step idx, i - becomes vectorized
    real :: h(grid_size)  ! real, dimension(grid_size), dh calculated on-the-fly

    if (grid_size <= 0) stop 'grid_size must be > 0'
    if (dt <= 0)        stop 'time step dt must be > 0'
    if (dx <= 0)        stop 'grid spacing dx must be > 0'
    if (c <= 0)         stop 'background flow speed c must be > 0'

    ! ========= The computation logic ============
    ! ============================================
    call set_gaussian(h, icenter, decay)
    print *, 0, h

    time_loop: do n = 1, num_time_steps
        h = h - c*diff(h) / dx*dt
        print *, n, h
    end do time_loop

contains
    ! set a vector to the gaussian values with (center/mean, decay/scale)
    subroutine set_gaussian(x, icenter, decay)
        real, intent(in out) :: x(:)
        integer, intent(in) :: icenter
        real, intent(in) :: decay
        integer :: i

        do concurrent(i = 1:size(x))
            x(i) = exp(-decay * (i - icenter)**2)
        end do
    end subroutine set_gaussian

    ! calculates the difference in space of a real-valued input vector
    ! hides the details of the implementation, e.g. the boundary condition
    pure function diff(x) result(dx)
        real, intent(in) :: x(:)  ! : assumes the shape of the passed array
        real :: dx(size(x))       ! same size as x
        integer :: im
        
        im = size(x)
        dx(1) = x(1) - x(im)            ! handle the boundary condition
        dx(2:im) = x(2:im) - x(1:im-1)  ! finite difference of other elements of x(:)
    end function diff
    
end program tsunami
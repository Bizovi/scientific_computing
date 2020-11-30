program tsunami
    implicit none

    ! parameter: if value is known at compile time and will not change
    integer, parameter :: grid_size = 100           ! constant, same line required init.
    integer, parameter :: num_time_steps = 100      ! simulation length
    real,    parameter :: dt = 1., dx = 1., c = 1.  ! time step, grid step, bg flow speed

    integer :: i, n                      ! i - space idx, n - time step idx
    real :: h(grid_size), dh(grid_size)  ! real, dimension(grid_size) :: h

    ! define the parameters and initialize the height grid/vector with a gaussian
    integer, parameter :: icenter = 25  ! central index
    real, parameter    :: decay = 0.02  ! shape factor (1/sigma)

    if (grid_size <= 0) stop 'grid_size must be > 0'
    if (dt <= 0)        stop 'time step dt must be > 0'
    if (dx <= 0)        stop 'grid spacing dx must be > 0'
    if (c <= 0)         stop 'background flow speed c must be > 0'

    ! embarassingly parallel problem, if huge can `do concurrent`
    init_grid: do concurrent (i = 1:grid_size)
        h(i)  = exp(-decay * (i - icenter) ** 2)
    end do init_grid

    print *, 0, h

    ! note the don't store h for every time step, just override
    time_loop: do n = 1, num_time_steps
        dh(1) = h(1) - h(grid_size)  ! periodic boundary condition on the left

        grid_partial: do concurrent (i = 2:grid_size)  ! handle the boundary condition
            dh(i) = h(i) - h(i-1)    ! finite difference of h in space
        end do grid_partial

        grid_forward: do concurrent (i = 1:grid_size)
            ! precedence is evaluated from left to right
            h(i) = h(i) - c * dh(i) / dx * dt  ! next time step for every cell
        end do grid_forward

        print *, n, h  ! print to the standard output - hackish way > data.txt
    end do time_loop

    
end program tsunami
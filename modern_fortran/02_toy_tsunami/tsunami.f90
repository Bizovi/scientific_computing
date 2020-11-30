program tsunami

    use iso_fortran_env, only: int32, real32
    use mod_initial, only: set_gaussian
    use mod_diff, only: diff
    implicit none

    ! ========= Declare vars and constants =======
    ! ============================================
    integer(int32), parameter :: grid_size = 100          ! constant, same line required init.
    integer(int32), parameter :: num_time_steps = 100     ! simulation length
    real(real32),   parameter :: dt = 1., dx = 1., c = 1. ! time step, grid step, bg flow speed
    integer(int32), parameter :: icenter = 25             ! mean of gaussian / central index
    real(real32),   parameter :: decay = 0.02             ! shape factor (1/sigma)

    integer(int32) :: n           ! n - time step idx, i - becomes vectorized
    real(real32) :: h(grid_size)  ! real, dimension(grid_size), dh calculated on-the-fly

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
    
end program tsunami
program cold_front

    implicit none
    integer :: n     ! applies to the whole program scope
    real :: nhours   ! the time interval
    real :: dt(8)

    ! method 1 - iterate with a do-loop
    do n = 6, 48, 6  ! every 6 hours
        nhours = real(n)  ! convert int to real
        print *, 'Temperature after ', nhours, ' hours is', &
        cold_front_temp(12., 24., 20., 960., nhours), ' degrees.'
    end do

    ! method 2 - vectorized
    dt = [6., 12., 18., 24., 30., 36., 42., 48.]
    print *, cold_front_temp(12., 24., 20., 960., dt)

contains
    ! A trivial calculation for the cold front, vectorized
    ! temp1, temp2 - temperatures at two points
    ! dx - distance in [km], c - speed in [km/h], dt = time step in [h]
    pure elemental function cold_front_temp(temp1, temp2, c, dx, dt) result(res)
        real, intent(in) :: temp1, temp2, c, dx, dt
        real :: res
        res = temp2 - c*(temp2 - temp1) / dx*dt
    end function cold_front_temp

end program cold_front
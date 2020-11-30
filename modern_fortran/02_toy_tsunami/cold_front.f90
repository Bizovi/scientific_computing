program cold_front

    implicit none
    integer :: n     ! applies to the whole program scope
    real :: nhours   ! the time interval

    do n = 6, 48, 6  ! every 6 hours
        nhours = real(n)  ! convert int to real
        print *, 'Temperature after ', nhours, ' hours is', &
        cold_front_temp(12., 24., 20., 960., nhours), ' degrees.'
    end do

contains

    ! A trivial calculation for the cold front
    ! temp1, temp2 - temperatures at two points
    ! dx - distance in [km], c - speed in [km/h], dt = time step in [h]
    real function cold_front_temp(temp1, temp2, c, dx, dt) result(res)
        real, intent(in) :: temp1, temp2, c, dx, dt
        res = temp2 - c*(temp2 - temp1) / dx*dt
    end function cold_front_temp

end program cold_front
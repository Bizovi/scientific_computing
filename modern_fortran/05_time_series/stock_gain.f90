program stock_gain

    use iso_fortran_env, only: real32, int32
    use mod_arrays, only: reverse
    use mod_io, only: read_stock
    implicit none

    character(len=4), allocatable :: symbols(:)
    character(len=:), allocatable :: time(:)
    real, allocatable :: open(:), high(:), low(:), close(:), adjclose(:), volume(:)

    integer(int32) :: n, i
    real(real32) :: gain

    symbols = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ ',&
        'IBM ', 'INTC', 'MSFT', 'NVDA', 'ORCL']

    firm_loop: do n = 1, size(symbols)
        call read_stock('data/' // trim(symbols(n)) // '.csv', &
            time, open, high, low, close, adjclose, volume)
        
        adjclose = reverse(adjclose)
        gain = (adjclose(size(adjclose)) - adjclose(1))

        if (n == 1) then
            print *, 'Symbol, Gain (USD), Relative gain (%), from, to'
            print *, '-----------------------------------------------'
        end if
        print *, symbols(n), gain, nint(gain / adjclose(1) * 100), & 
            time(size(time)) // ' ' // time(1)  ! nint - nearest integer
    end do firm_loop
end program stock_gain
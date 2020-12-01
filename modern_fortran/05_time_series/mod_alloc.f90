module mod_alloc
    implicit none
    public :: free_, alloc
    
contains
    ! wrapper for deallocating the array
    subroutine free_(a)
        real, allocatable, intent(in out) :: a(:)
        integer :: stat
        character(100) :: errmsg

        if (.not. allocated(a)) return
        deallocate(a, stat=stat, errmsg=errmsg)
        if (stat > 0) error stop errmsg
    end subroutine free_

    ! if allocated, deallocate before allocating
    ! allocate array of size n, print error on exception
    subroutine alloc(a, n)
        real, allocatable, intent(in out) :: a(:)
        integer, intent(in) :: n
        integer :: stat
        character(100) :: errmsg

        if (allocated(a)) call free_(a)
        allocate(a(n), stat=stat, errmsg=errmsg)
        if (stat > 0) error stop errmsg
    end subroutine alloc
    
end module mod_alloc
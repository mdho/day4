module m_allocate
    !defines subroutines for allocating single or double arrays of rank 2 
    integer,parameter :: single=kind(1.0e0)
    integer,parameter :: double=kind(1.0d0)
    interface alloc
        module procedure allocs,allocd
    end interface
contains
    subroutine allocs(field,nx,ny,stat)
        implicit none
        real(kind=single), pointer, dimension(:,:), intent(inout) :: field
        integer, intent(in) :: nx,ny
        integer, optional, intent(out) :: stat
        ! temporary pointer for field for re-allocation
        real(kind=single), pointer, dimension(:,:) :: temp
        integer :: nx_old, ny_old

        if (.not. associated(field)) then 
            ! no previous value
            ! allocate space for field
            if (present(stat)) then
                allocate(field(nx,ny),stat=stat)
            else 
                allocate(field(nx,ny))
            endif
        else 
            ! has previous values
            nx_old = size(field,1)
            ny_old = size(field,2)

            ! allocate space for temp
            if (present(stat)) then
                allocate(temp(nx,ny),stat=stat)
            else 
                allocate(temp(nx,ny))
            endif
            ! copy previous data to temp
            temp(1:nx_old,1:ny_old)=field
            ! deallocate previous space
            !deallocate(field)
            ! assign new space to field
            field => temp
        endif
    end subroutine
    subroutine allocd(field,nx,ny,stat)
        implicit none
        real(kind=double), pointer, dimension(:,:), intent(inout) :: field
        integer, intent(in) :: nx,ny
        integer, optional, intent(out) :: stat
        ! temporary pointer for field for re-allocation
        real(kind=double), pointer, dimension(:,:) :: temp
        integer :: nx_old, ny_old

        if (.not. associated(field)) then 
            ! no previous value
            ! allocate space for field
            if (present(stat)) then
                allocate(field(nx,ny),stat=stat)
            else 
                allocate(field(nx,ny))
            endif
        else 
            ! has previous values
            nx_old = size(field,1)
            ny_old = size(field,2)

            ! allocate space for temp
            if (present(stat)) then
                allocate(temp(nx,ny),stat=stat)
            else 
                allocate(temp(nx,ny))
            endif
            ! copy previous data to temp
            temp(1:nx_old,1:ny_old)=field
            ! deallocate previous space
            !deallocate(field)
            ! assign new space to field
            field => temp
        endif
    end subroutine
end module m_allocate

module m_init
    public :: init_data
contains
    subroutine init_data()
        use m_data
        use m_allocate
        integer :: st,nx,ny
        ! diffusion constant
        d = 1
        ! number of samples (time and space)
        nt=200
        nx=21
        ny=21

        dx=1./(nx-1)
        dy=1./(ny-1)
        dt = min(dx,dy)**2/(4*d)

        nullify(temp,temp_old)
        ! allocate fields temp and temp_ol
        call alloc(temp,nx,ny,stat=st)
        if (.not.(st.eq.0)) then
            print*,'allocation error for temp'
        endif
        call alloc(temp_old,nx,ny,stat=st)
        if (.not.(st.eq.0)) then
            print*,'allocation error for temp_old'
        endif

        ! boundary and initial conditions
        temp_old(1:nx,1:ny) = 1.
        temp_old(2:(nx-1),2:(ny-1))=0.
        temp(1:nx,1:ny) = 1.
        temp(2:(nx-1),2:(ny-1))=0.
    end subroutine init_data
end module m_init

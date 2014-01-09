module m_io
    public :: to_file
contains
    subroutine to_file(timestep)
        use m_data, only: temp,dx,dy
        implicit none
        integer, optional :: timestep
        character(len=20) :: fname
        integer :: nx,ny,j,i
        nx = size(temp,1)
        ny = size(temp,2)

        if (present(timestep)) then
            write(fname,'(A,I6.6,A)') 'diff.',timestep,'.dat'
        else
            fname = 'diff.dat'
        endif

        !output to file
        open(10,FILE=fname)
        do j=1,ny
            do i=1,nx
                write(10,'(3E12.4)') REAL(i-1)*dx, REAL(j-1)*dy,temp(i,j)
            enddo
            write(10,'(A)') !new line
        enddo
        close(10)
    end subroutine
end module m_io

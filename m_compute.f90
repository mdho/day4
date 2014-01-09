module m_compute
contains
    subroutine compute()
        use m_data
        use m_copy
        use m_io
        integer :: nx,ny
        nx = size(temp,1)
        ny = size(temp,2)
        do, k=1,nt !loop over nt timesteps
            do, j=2,ny-1 
                do, i=2,nx-1 !loop over all (x,y) values within the boundary
                    temp(i,j)=dt*d*((temp_old(i+1,j)-2*temp_old(i,j)&
                                    +temp_old(i-1,j))/dx**2 &
                                    +(temp_old(i,j+1)-2*temp_old(i,j)&
                                    +temp_old(i,j-1))/dy**2) &
                                    +temp_old(i,j)
                enddo
            enddo
            call copy_temp(temp_old,temp)
        enddo
    end subroutine compute
end module m_compute

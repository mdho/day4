module m_compute
contains
    subroutine compute()
        use m_data, only: dx,dy,dt,d,nt,temp,temp_old
        use m_copy, only: copy_temp
        use m_time, only: tic,toc,diag
        implicit none
        integer :: nx,ny,k,j,i,t_cpu,t_wc
        real :: min_value

        nx = size(temp,1)
        ny = size(temp,2)
        call tic()
        do, k=1,nt !loop over nt timesteps
            ! largest possible value:
            min_value=huge(min_value)
            do, j=2,ny-1 
                do, i=2,nx-1 !loop over all (x,y) values within the boundary
                    temp(i,j)=dt*d*((temp_old(i+1,j)-2*temp_old(i,j)&
                                    +temp_old(i-1,j))/dx**2 &
                                    +(temp_old(i,j+1)-2*temp_old(i,j)&
                                    +temp_old(i,j-1))/dy**2) &
                                    +temp_old(i,j)
                    !find minimum value of matrix
                    if (temp(i,j).lt.min_value) then
                        min_value = temp(i,j)
                    endif
                enddo
            enddo
            call copy_temp(temp_old,temp)
            ! for every 10'th iteration, write to diag.dat
            if (mod(k,10).eq.0) then
                call diag(min_value)
            endif
        enddo
        call diag(min_value,terminate=.true.)
        call toc()
    end subroutine compute
end module m_compute

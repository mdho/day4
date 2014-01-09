module m_time
    integer,private :: n_clock
    real,private :: t_cpu
contains
    subroutine date_and_time_string(str)
        implicit none
        character(len=50), intent(out) :: str
        character(len=*), parameter :: fs = '(I4,a,I2.2,a,I2.2,a,I2.2,a,I2.2,a,I2.2,a,I3.3)'
        integer, dimension(8) :: tv
        call date_and_time(values=tv)
        write(str,fs),tv(1),'-',tv(2),'-',tv(3),' at ',tv(5),':',tv(6),':',tv(7),'.',tv(8)
    end subroutine
    subroutine tic()
        integer :: c
        call system_clock(count=n_clock)
        call cpu_time(t_cpu)
    end subroutine
    subroutine toc()
        implicit none
        integer :: n_clock_end,cr
        real :: t_cpu_end
        call system_clock(count=n_clock_end,count_rate=cr)
        call cpu_time(t_cpu_end)
        print*,'CPU time: ',t_cpu_end-t_cpu,'s'
        print*,'WC time: ',real(n_clock_end-n_clock)/real(cr),'s'
    end subroutine toc
    subroutine diag(min_value,terminate)
        implicit none
        real,intent(in) :: min_value
        logical,optional,intent(in) :: terminate

        logical :: first = .true.
        real, save :: first_cpu_time
        real :: current_cpu_time
        
        if (present(terminate)) then
            if (terminate) then 
                first = .true.
                return
            endif
        endif

        if (first) then
            open(20,FILE='diag.dat')
            call cpu_time(first_cpu_time)
            first=.false.
        else
            call cpu_time(current_cpu_time)
            write(20,*),(current_cpu_time-first_cpu_time),min_value
        endif 
    end subroutine diag
end module m_time

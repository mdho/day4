module m_time
contains
    subroutine date_and_time_string(str)
        character(len=50), intent(out) :: str
        character(len=*), parameter :: fs = '(I4,a,I2.2,a,I2.2,a,I2.2,a,I2.2,a,I2.2,a,I3.3)'
        integer, dimension(8) :: tv
        call date_and_time(values=tv)
        write(str,fs),tv(1),'-',tv(2),'-',tv(3),' at ',tv(5),':',tv(6),':',tv(7),'.',tv(8)
    end subroutine
end module m_time

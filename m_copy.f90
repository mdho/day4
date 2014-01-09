module m_copy
    integer,parameter :: single=kind(1.0e0)
    integer,parameter :: double=kind(1.0d0)
    interface copy_temp
        module procedure copy_temps,copy_tempd
    end interface
contains
    elemental subroutine copy_temps(t_to,t_from)
        implicit none
        real(kind=single), intent(out) :: t_to
        real(kind=single), intent(out) :: t_from
        t_to=t_from
    end subroutine
    elemental subroutine copy_tempd(t_to,t_from)
        implicit none
        real(kind=double), intent(out) :: t_to
        real(kind=double), intent(out) :: t_from
        t_to=t_from
    end subroutine
end module m_copy

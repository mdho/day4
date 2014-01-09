module m_data
    integer,parameter :: single=kind(1.0e0)
    integer,parameter :: double=kind(1.0d0)
    integer :: i,j,k,nt !i,y,k are x,y,and t-indices
    real :: dx,dy,dt,d
    real(kind=single),pointer, dimension(:,:) :: temp, temp_old
end module m_data

program ex3
    use m_init, only: init_data
    use m_compute, only: compute
    use m_io, only: to_file
    use m_time, only: date_and_time_string
    implicit none
    character(len=50) :: time
    call date_and_time_string(time)
    print*,"initiating simulation at: ",time
    call init_data()
    call compute()
    call date_and_time_string(time)
    print*,"completed simulation at: ",time
    call to_file()
contains
end program ex3

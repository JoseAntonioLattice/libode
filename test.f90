program test

  use iso_fortran_env, only : dp => real64
  use ode, only : solve, create_time_array
  implicit none

  integer, parameter :: n = 1000
  integer, parameter :: m = 1
  real(dp), dimension(m,n) :: x
  real(dp), dimension(n) :: t

  integer :: i

  call create_time_array(t,0.0_dp,0.01_dp,n)
  call solve(f,x,t,[1.0_dp],0.01_dp,"rk4")

  do i = 1, n
     write(*,*) t(i), x(:,i)
  end do
  
contains

  pure function f(x,t)
    real(dp), intent(in) :: x(:)
    real(dp), intent(in) :: t
    real(dp), dimension(size(x)) :: f

    f(1) = -x(1) 
    
  end function f
  
end program test

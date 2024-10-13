module ode

  use iso_fortran_env, only : dp => real64, i4 => int32
  implicit none

  abstract interface
    pure function ode_function(x,t)
      use iso_fortran_env, only : dp => real64
      implicit none
      real(dp), intent(in) :: x(:), t
      real(dp), dimension(size(x)) :: ode_function
    end function ode_function
  end interface

  abstract interface
    function method_function(x,t,dt,f)
      use iso_fortran_env, only : dp => real64
      implicit none
       real(dp), intent(in) :: x(:),t,dt
       real(dp), dimension(size(x)) :: method_function
       procedure(ode_function) :: f
     end function method_function
 end interface
 
contains

  subroutine solve(f,x,t,x0,dt,algorithm)
    real(dp), dimension(:,:), intent(out) :: x
    real(dp), dimension(:), intent(in) :: t
    real(dp), intent(in), dimension(size(x(:,1))) :: x0
     real(dp), intent(in) :: dt!, t0
    character(*), intent(in) :: algorithm
    procedure(ode_function) :: f
    integer(i4) :: i, n

    n = size(t(:))

    !call create_time_array(t,t0,dt,n)
    x(:,1) = x0

    select case(algorithm)
    case('euler')
       call loop_solve(euler,f,x,t,dt)
    case('rk4')
       call loop_solve(rk4,f,x,t,dt)
    case default
      stop 'Unrecognized algorithm. Choose between "euler" or "rk4"'
    end select

  end subroutine solve

  subroutine loop_solve(g,f,x,t,dt)
    procedure(method_function) :: g
    procedure(ode_function) :: f  
    real(dp), dimension(:,:), intent(inout) :: x
    real(dp), dimension(:), intent(in) :: t
    real(dp), intent(in) :: dt

    integer(i4) :: i
    
    do i = 1, size(t) - 1
       x(:,i+1) = g(x(:,i),t(i),dt,f)
    end do
   end subroutine loop_solve
  
  subroutine create_time_array(t,t0,dt,n)
    integer(i4), intent(in) :: n
    real(dp), dimension(n), intent(out) :: t
    real(dp), intent(in) :: t0, dt
    integer(i4) :: i

    do i = 1, n
      t(i) = t0 + dt * (i-1)
    end do

  end subroutine create_time_array

  pure function euler(x,t,dt,f)
    real(dp), intent(in) :: x(:),t,dt
    real(dp), dimension(size(x)) :: euler
    procedure(ode_function) :: f

      euler = f(x,t)*dt + x

  end function euler

  pure function rk4(x,t,dt,f)
    real(dp), intent(in) :: x(:),t,dt
    real(dp), dimension(size(x)) :: rk4
    real(dp), dimension(size(x)) :: k1, k2, k3, k4
    procedure(ode_function) :: f

      k1 = f(x,t)
      k2 = f( x + 0.5*dt * k1, t + 0.5*dt )
      k3 = f( x + 0.5*dt * k2, t + 0.5*dt )
      k4 = f( x +     dt * k3, t +     dt )

      rk4 = x + dt * (k1 + 2*k2 + 2*k3 + k4)/6

  end function rk4

end module ode

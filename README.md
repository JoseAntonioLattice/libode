# ODE (Ordinary Differential Equations) library

This library has routines to solve system of ordinary differential equations.

$$ \frac{d \vec{x}}{dt} = \vec{f}(\vec{x},t). $$

## Installation

- First clone the repository:

```
	git clone
```

- Move to the directory where you clone the repository and run
```
	make all
```
this will compile and install the library `libode.so` on `$HOME/Fortran/lib`


## Use

- Import the module into your program
```fortran
  program main

    use ode
    implicit none

    !!!!!!!!!!!
    ! your code
    !!!!!!!!!!!

  end program main
```
- Call the subroutine solve
```fortran
	call solve(f,x,t,x0,dt,algorithm)
```
+ f: is the function on the right hand side of equation $\frac{d \vec{x}}{dt} = \vec{f}(\vec{x},t)$.
+ x: is arank 2 array x(:,:). The first entry is the array $\vec{x}$, the second entry
      is the time array.
* x0: is the intial conditions array.
- t: is the time array.
- dt: is the time step.
- algorithm: is a string. It can be "euler" or "rk4".

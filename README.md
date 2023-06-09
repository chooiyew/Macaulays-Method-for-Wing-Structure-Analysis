# Macaulays-Method-for-Wing-Structure-Analysis

This MATLAB program solves multiple complex loading conditions on aircraft wing by assuming the wing is made out of two Euler-Bernoulli beams with square cross section. This description includes the [scenario given](#scenario-given), [program's objective](#programs-objectives), [proposed solution](#solution-proposed), [results](#results) from MATLAB and lastly a [table of content](#table-of-content) explaining each file in this repository.

--- 
## Scenario given
[[Figure 1](#figure1)] show the orthographic drawing of a flight. As a structure engineer, you are requested to estimate the size of supporting beam for the wing. Based on the design, the wing is supported by two square beams as show in Figure 2 and the material for the beam is Carbon – Graphite with the modulus of elasticity 25 GPA.

<a name="figure1"></a> ![Figure1](Figure1.png)
<a name="figure2"></a> ![Figure2](Figure2.png)

Given the dry weight for the Turbine is 1950kg, and the uniform distribution weight for wing is 135 kg/meter. The distribution of fuel weight a along the wing is shown in the [[Figure 3](#figure3)].

<a name="figure3"></a> ![Figure3](Figure3.png)

Let assume the lift force acting on the wing as in [[Figure 4](#figure4)], and then the distribution lift force can be calculated in the equation below.

$$ w_L = - \dfrac{2}{17}\rho x V^2 C_L + 2.55 \rho V^2 C_L  $$

Where,
$\rho$ is density for air 1.225 kg/m3

$V$ is speed (0 km/h to 750 km/h)

$CL$ is lift coefficient depend on attack angle ($CL$ = 0.09 $\alpha$ + 0.4)

$\alpha$ is attack angle (0 deg to 15 deg)

$x$ is the distance from body

<a name="figure4"></a> ![Figure4](Figure4.png)

--- 
## Program's objectives
* a)  To determine the cross section of the beam if the maximum deflection of the wing must not larger than 0.5 meter.
* b) To calculate the location and at what condition happen the maximum transverse stress.
* c) To calculate the location and at what condition happen the maximum bending stress.
* d) To plot the 2D graph maximum shear force verse speed for the angle of attack 0 deg., 10 deg. and 15 deg. in same graph.
* e) To plot the 2D graph maximum bending moment verse speed for the angle of attack 0 deg., 10 deg. and 15 deg. in same graph.
* f) To plot the 2D graph deflection verse speed for the angle of attack 0 deg., 10 deg. and 15 deg. in same graph.
* g) To plot the 3D graph for shear force with the step size for speed 50km/h and step size for angle attack 1 deg.
* h) To plot the 3D graph for bending moment with the step size for speed 50km/h and step size for angle attack 1 deg.
* i) To plot the 3D graph for deflection with the step size for speed 50km/h and step size for angle attack 1 deg.

--- 
## Solution proposed
Before constructing any codes in MATLAB, a correct Macaulay equation is very important for any further calculations. Therefore, we need to first draw a free body diagram of the scenario as shown in [[Figure 5](#figure5)].

<a name="figure5"></a> ![Figure5](Figure5.png)

Given :

- Weight of fuel = 15.2kg/m at x=0 , 7.78kg/m at x=15.3
- Weight of turbine = 1950kg at x=3
- Weight of wing = 135kg/m throughout 
- Lift force = $ -2/17 \rho xv^2 C_L+2.55\rho v^2 C_L $ N/m throughout

Where 
- $\rho$= density of air 1.225 kg/m3 
- $v$ = speed (0-750 km/h)
- $C_L$ = lift coefficient depends on angle of attack ($C_L=0.09\rho+0.4$)
- $\alpha$ = angle of attack (0-15 deg.)
- $x$ = distance from body

By applying $\sum{M_o=0}$ , (clockwise positive)

We get
$$0=M+\frac{\left(135\right)\left(9.81\right)\left(15.3\right)^2}{2}+\left(1950\right)\left(9.81\right)\left(3\right)+\frac{\left(7.78\right)\left(9.81\right)\left(15.3\right)^2}{2}+\frac{\left(7.42\right)\left(9.81\right)\left(15.3\right)^2}{6}-2.55\left(1.225\right)v^2C_L\left(\frac{15.3}{2}\right)\left(15.3\right)-\frac{2}{17}\left(1.225\right)v^2C_L\left(\frac{2}{3}\right)\left({15.3}^2\right)\left(\frac{1}{2}\right) $$

By applying $\sum{F_y=0} $, (upward positive)

We get
$$0=R-\left(135\right)\left(9.81\right)\left(15.3\right)-\left(1950\right)\left(9.81\right)-\left(7.81\right)\left(9.81\right)(15.3)-\frac{1}{2}\left(7.42\right)\left(15.3\right)\left(9.81\right)+2.55\left(1.225\right)v^2C_L\left(15.3\right)-\frac{2}{17}\left(1.225\right)v^2C_L\left({15.3}^2\right)\left(\frac{1}{2}\right)$$

In both the equations above, note that there are two unknowns, the speed of the aircraft(v) and the lift coefficient(C_L). Therefore, when we code in MATLAB, looping is required to evaluate the different reaction forces(R) and moments(M) at the fixed support at different speed and angle of attack and stores the values in the form of 2D array.

After that, Macaulay equation can be constructed according to the free body diagram as shown in [[Figure 6](#figure6)] below :

<a name="figure6"></a> ![Figure6](Figure6.png)

$\sum M_{X-X}=EI\frac{dy^2}{dx^2}$, (clockwise positive)

We get
$$EI\frac{dy^2}{dx^2}=-\left(\frac{1}{2}\right)\left(15.2\right)\left(9.81\right)x^2-\left(\frac{1}{2}\right)\left(135\right)\left(9.81\right)x^2 -\left(1950\right)\left(9.81\right)(x-3)+Mx^0+Rx+\frac{\left(7.42\right)\left(9.81\right)}{\left(6\right)\left(15.3\right)}x^3 +(1/2)(2.55)(1.225)\ v^2\ C_L x^2-(2/17)(1.225)\ v^2\ C_L\ \ (x^3)/6 $$

###
Integrate the equation above

$$EI\frac{dy}{dx}=-\left(\frac{1}{6}\right)\left(15.2\right)\left(9.81\right)x^3-\left(\frac{1}{6}\right)\left(135\right)\left(9.81\right)x^3 -\left(\frac{1}{2}\right)\left(1950\right)\left(9.81\right)(x-3)^2+Mx^1+\frac{R}{2}x^2+\frac{\left(7.42\right)\left(9.81\right)}{\left(24\right)\left(15.3\right)}x^4 +\left(\frac{1}{6}\right)\left(2.55\right)\left(1.225\right)v^2C_L x^3-\left(\frac{2}{17}\right)\left(1.225\right)v^2C_L\frac{x^4}{24}+C$$


Above is the slope equation, to fulfil the requirements of this project, we need the deflection equation where the slope equation will be integrated again.

$$EI\delta=-\left(\frac{1}{24}\right)\left(15.2\right)\left(9.81\right)x^4-\left(\frac{1}{24}\right)\left(135\right)\left(9.81\right)x^4 -\left(\frac{1}{6}\right)\left(1950\right)\left(9.81\right)(x-3)^3+\frac{M}{2}x^2+\frac{R}{6}x^3+\frac{\left(7.42\right)\left(9.81\right)}{\left(120\right)\left(15.3\right)}x^5 +\left(\frac{1}{24}\right)\left(2.55\right)\left(1.225\right)v^2C_L x^4-\left(\frac{2}{17}\right)\left(1.225\right)v^2C_L\frac{x^5}{120}+Cx+D$$


Above is the deflection that we desire. However, before we code the equation into MATLAB, we have to solve for the unknows C and D.

From slope equation, when x=0, slope at fixed support is 0,

$$ 0=0+C $$
$$ C=0 $$

From deflection equation, when x=0, deflection at fixed support is 0,

$$ 0=0+D $$
$$ D=0 $$


Therefore, our final deflection equation is as follow :

$$EI\delta=-\left(\frac{1}{24}\right)\left(15.2\right)\left(9.81\right)x^4-\left(\frac{1}{24}\right)\left(135\right)\left(9.81\right)x^4 -\left(\frac{1}{6}\right)\left(1950\right)\left(9.81\right)(x-3)^3+\frac{M}{2}x^2+\frac{R}{6}x^3+\frac{\left(7.42\right)\left(9.81\right)}{\left(120\right)\left(15.3\right)}x^5 +\left(\frac{1}{24}\right)\left(2.55\right)\left(1.225\right)v^2C_L x^4-\left(\frac{2}{17}\right)\left(1.225\right)v^2C_L\frac{x^5}{120}$$

To ease the coding process, the equation above will be split into few small and simple parts by using superposition theory.

- Fuel weight component = $-(1/24)(15.2)(9.81)x^4+(7.42)(9.81)/(120)(15.3)\ x^5$
- Turbine component = $-\left(\frac{1}{6}\right)\left(1950\right)\left(9.81\right)(x-3)^3$
- Wing weight component = $-\left(\frac{1}{24}\right)\left(135\right)\left(9.81\right)x^4$
- Lift force component = $+\left(\frac{1}{24}\right)\left(2.55\right)\left(1.225\right)v^2C_L x^4-\left(\frac{2}{17}\right)\left(1.225\right)v^2C_L\frac{x^5}{120}$
- Moment at support = $+\frac{M}{2}x^2$
- Reaction at support = $+\frac{R}{6}x^3$

The varying variable in the deflection equation is x, a looping is then made to evaluate the deflection at x=0 to x=15.3. this looping should be within the looping for speed and angle of attack as those will affect the value of R and M for every loop.

To determine the cross-section of the beam with a maximum deflection of 0.5m, we need to calculate the value of area moment of inertia, I.

$$I=\frac{1}{(25\ast{10}^9)(0.5)}[-\left(\frac{1}{24}\right)\left(15.2\right)\left(9.81\right)x^4-\left(\frac{1}{24}\right)\left(135\right)\left(9.81\right)x^4 -\left(\frac{1}{6}\right)\left(1950\right)\left(9.81\right)(x-3)^3+\frac{M}{2}x^2+\frac{R}{6}x^3+\frac{\left(7.42\right)\left(9.81\right)}{\left(120\right)\left(15.3\right)}x^5 +\left(\frac{1}{24}\right)\left(2.55\right)\left(1.225\right)v^2C_L x^4-\left(\frac{2}{17}\right)\left(1.225\right)v^2C_L\frac{x^5}{120}]$$

To get the I for a single beam, we divide the I by 2,

$$ I_{single}=\frac{I}{2} $$

To calculate the cross-sectional area, we apply the formula of area moment of inertia

$$ \frac{1}{12}t^4=I_{single} $$

The cross-sectional area, $A = t^2 m^2$

To determine the location of  position and location of maximum transverse stress and maximum bending stress, the equations of both stresses must be studied.

Transverse stress = $\frac{VQ}{IT}$ and bending stress = $\frac{Mc}{I}$

Where
- $V$ = Shear force
- $Q$ = First moment of area 
- $I$ = Second moment of area
- $T$ = Thickness of the cross-section
- $M$ = Bending moment
- $c$ = Radius of interest

From the two equations above, we can conclude that the first moment of area, second moment of area, thickness of the cross-section and the radius of interest is fixed along the beam. The only differentiating factor in both cases is the shear force and the bending moment. Thus, to determine the maximum transverse stress and maximum bending stress, we need to consider only the maximum shear force and maximum bending moment.

Since the values of force and bending moment is stored in 3D arrays, we can simply quote the location of the maximum values by MATLAB command of “ind2sub”. It will return the position of the maximum value in 3 single variables for row, column and page.

To plot graphs in MATLAB, commands like “plot(x,y)” and “surfc(x,y,z)” are used. The size of the array in x,y and z axis must be equal to each other. Commands like “meshgrid”, “xlabel”, “ylabel”, “zlabel”, “title” are also used to provide a better visual representation of the graphs.

## Results
The following is the result from MATLAB program attached.
- For question a)
    - The cross section of the beam is 0.609 m^2.

- For question b)
    - The maximum transverse stress occurs at point x=0.00,with the conditions of speed 750 km per h and angle of attack 15 degree.

- For question c)
    - The maximum bending stress occurs at point x=0.00,with the conditions of speed 750 km per h and angle of attack 15 degree.

- For question d), e), f), g), h), i),
    ![Results](Results.png)


--- 
## Table of content
| File                                       | Description                                    |
|:------------------------------------------:|:----------------------------------------------:|
| [Macaulays_method.m](/Macaulays_method.m/) | MATLAB program solving the scenario explained  |
| [Figure1.png](/Figure1.png/)               | Aircraft orthographic drawing                  |
| [Figure2.png](/Figure2.png/)               | Beam arrangement of wing                       |
| [Figure3.png](/Figure3.png/)               | Distribution of fuel weight along the wing     |
| [Figure4.png](/Figure4.png/)               | Projected area of the wing                     |
| [Figure5.png](/Figure5.png/)               | Free body diagram of load distribution on wing |
| [Figure6.png](/Figure6.png/)               | Macaulay's method on the free body diagram     |


# Macaulays-Method-for-Wing-Structure-Analysis

This MATLAB program solves multiple complex loading conditions on aircraft wing by assuming the wing is made out of two Euler-Bernoulli beams with square cross section.

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


--- 
## Table of content



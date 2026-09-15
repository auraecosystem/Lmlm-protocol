This is a powerful collection of foundational mathematical and differential models spanning population dynamics, epidemiology, stochastic processes, and quantitative finance.

Here is a clean, organized breakdown of these models categorized by their field of application:

---

### 1. Population Dynamics & Ecology

* **Exponential Growth Model**
Describes unconstrained growth where the rate of increase is proportional to the current population size.

$$P = P_0 e^{rt}$$



*(Where $P_0$ is initial population, $r$ is growth rate, and $t$ is time.)*
* **Logistic Growth Model**
Refines exponential growth by accounting for environmental carrying capacity ($K$), slowing growth as resources become scarce.

$$P = \frac{K}{1 + Ae^{-rt}}$$



*(Where $A$ is a constant determined by initial conditions.)*
* **Lotka–Volterra Predator-Prey Model**
A pair of first-order non-linear differential equations describing the cyclical dynamics of predator ($y$) and prey ($x$) populations.

$$\dot{x} = ax - bxy$$


$$\dot{y} = -cy + dxy$$



---

### 2. Epidemiology

* **SIR Disease Model**
A compartmental model tracking Susceptible ($S$), Infected ($I$), and Recovered ($R$) populations over time during an outbreak.

$$S' = -\beta SI$$


$$I' = \beta SI - \gamma I$$



*(Where $\beta$ is the transmission rate and $\gamma$ is the recovery rate.)*

---

### 3. Probability & Stochastic Processes

* **Markov Chain Transition Probability**
Defines the probability of transitioning from state $i$ to state $j$ in the next discrete time step, satisfying the memoryless property.

$$P(X_{n+1} = j \mid X_n = i) = P_{ij}$$



---

### 4. Quantitative Finance

* **Black–Scholes Partial Differential Equation**
The cornerstone PDE used in financial mathematics to determine the pricing of European-style options over time.

$$\frac{\partial V}{\partial t} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 V}{\partial S^2} + rS \frac{\partial V}{\partial S} - rV = 0$$



*(Where $V$ is option price, $S$ is underlying asset price, $\sigma$ is volatility, and $r$ is the risk-free rate.)*

---


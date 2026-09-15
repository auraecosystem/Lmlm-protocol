import numpy as np
import pandas as pd
from scipy.integrate import solve_ivp

class ComprehensiveSimulationEngine:
    """Unified engine for deterministic, epidemiological, ecological, and stochastic models."""

    def __init__(self, time_span, num_points):
        self.t_start, self.t_end = time_span
        self.num_points = num_points
        self.t_eval = np.linspace(self.t_start, self.t_end, num_points)

    # 1. Exponential Growth: P = P_0 * e^(rt)
    def run_exponential_growth(self, p0, r):
        p = p0 * np.exp(r * self.t_eval)
        return pd.DataFrame({'Time': self.t_eval, 'Population': p})

    # 2. Logistic Growth: P = K / (1 + A * e^(-rt))
    def run_logistic_growth(self, k, a, r):
        p = k / (1.0 + a * np.exp(-r * self.t_eval))
        return pd.DataFrame({'Time': self.t_eval, 'Population': p})

    # 3. Lotka–Volterra Predator-Prey Model
    @staticmethod
    def _lv_ode(t, y, a, b, c, d):
        x, prey_y = y
        return [a * x - b * x * prey_y, -c * prey_y + d * x * prey_y]

    def run_lotka_volterra(self, initial_state, a, b, c, d):
        sol = solve_ivp(
            self._lv_ode, [self.t_start, self.t_end], initial_state, 
            t_eval=self.t_eval, args=(a, b, c, d)
        )
        return pd.DataFrame({
            'Time': sol.t, 
            'Prey_X': sol.y[0], 
            'Predator_Y': sol.y[1]
        })

    # 4. SIR Disease Model
    @staticmethod
    def _sir_ode(t, y, beta, gamma):
        s, i, r = y
        return [-beta * s * i, beta * s * i - gamma * i, gamma * i]

    def run_sir(self, initial_state, beta, gamma):
        sol = solve_ivp(
            self._sir_ode, [self.t_start, self.t_end], initial_state, 
            t_eval=self.t_eval, args=(beta, gamma)
        )
        return pd.DataFrame({
            'Time': sol.t, 
            'Susceptible': sol.y[0], 
            'Infected': sol.y[1], 
            'Recovered': sol.y[2]
        })

    # 5. Markov Chain Transition Simulation
    def run_markov_chain(self, transition_matrix, initial_state, steps):
        """Simulates discrete-time state transitions."""
        states = [initial_state]
        current_state = initial_state
        matrix = np.array(transition_matrix)
        
        for _ in range(steps - 1):
            next_state = np.random.choice(
                len(matrix), p=matrix[current_state]
            )
            states.append(next_state)
            current_state = next_state
            
        return pd.DataFrame({'Step': range(steps), 'State': states})

    # 6. Black–Scholes Monte Carlo Simulation (Geometric Brownian Motion)
    def run_black_scholes_mc(self, s0, r_rate, sigma, num_paths=100):
        """Simulates asset paths for option pricing / stochastic analysis."""
        dt = (self.t_end - self.t_start) / self.num_points
        paths = np.zeros((self.num_points, num_paths))
        paths[0] = s0
        
        for t in range(1, self.num_points):
            z = np.random.standard_normal(num_paths)
            paths[t] = paths[t-1] * np.exp(
                (r_rate - 0.5 * sigma**2) * dt + sigma * np.sqrt(dt) * z
            )
            
        df = pd.DataFrame(paths, columns=[f'Path_{i+1}' for i in range(num_paths)])
        df.insert(0, 'Time', self.t_eval)
        return df


# --- Execution Example ---
if __name__ == "__main__":
    engine = ComprehensiveSimulationEngine(time_span=(0, 50), num_points=100)
    
    # Run SIR simulation dataset
    sir_df = engine.run_sir(initial_state=[990, 10, 0], beta=0.0015, gamma=0.1)
    print("--- SIR Model Sample ---")
    print(sir_df.head(3))
    
    # Run Black-Scholes Monte Carlo sample
    bs_df = engine.run_black_scholes_mc(s0=100, r_rate=0.05, sigma=0.2, num_paths=3)
    print("\n--- Black-Scholes Path Sample ---")
    print(bs_df.head(3))

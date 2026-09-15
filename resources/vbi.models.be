class JR_sde(par={})[source]
Jansen-Rit model C++ implementation.

Parameters:
par: dict
Including the following: - A : [mV] determine the maximum amplitude of the excitatory PSP (EPSP) - B : [mV] determine the maximum amplitude of the inhibitory PSP (IPSP) - a : [Hz] 1/tau_e,  of the reciprocal of the time constant of passive membrane and all other spatially distributed delays in the dendritic network - b : [Hz] 1/tau_i - r [mV] the steepness of the sigmoidal transformation. - v0 parameter of nonlinear sigmoid function - vmax parameter of nonlinear sigmoid function - C_i [list or np.array] average number of synaptic contacts in th inhibitory and excitatory feedback loops - noise_amp - noise_std
dt [second] integration time step
t_initial [s] initial time
t_end [s] final time
method [str] method of integration
t_transition [s] time to reach steady state
dim [int] dimention of the system
valid_params = ['noise_seed', 'seed', 'G', 'weights', 'A', 'B', 'a', 'b', 'noise_mu', 'noise_std', 'vmax', 'v0', 'r', 'C0', 'C1', 'C2', 'C3', 'dt', 'method', 't_transition', 't_end', 'control', 'output', 'RECORD_AVG', 'initial_state']
check_parameters(par)[source]
Check if the parameters are valid.
get_default_parameters()[source]
return default parameters for the Jansen-Rit sde model.
set_initial_state()[source]
Set initial state for the system of JR equations with N nodes.
prepare_input()[source]
prepare input parameters for passing to C++ engine.
run(par={}, x0=None, verbose=False)[source]
Integrate the system of equations for Jansen-Rit sde model.

Parameters:
par: dict
parameters to control the Jansen-Rit sde model.
x0: np.array
initial state
verbose: bool
print the message if True
Returns:
dict
t : time series
x : state variables
class JR_sdde(par={})[source]
valid_params = ['weights', 'delays', 'dt', 't_end', 'G', 'A', 'a', 'B', 'b', 'mu', 'nstart', 't_end', 't_transition', 'sigma', 'C', 'record_step', 'C0', 'C1', 'C2', 'C3', 'vmax', 'r', 'v0', 'output', 'sti_ti', 'sti_duration', 'sti_amplitude', 'sti_gain', 'noise_seed', 'seed', 'method']
check_parameters(par)[source]
check if the parameters are valid
get_default_parameters()[source]
get default parameters for the system of JR equations.
prepare_stimulus(sti_gain, sti_ti)[source]
prepare stimulation parameteres
set_initial_state()[source]
set initial state for the system of JR equations with N nodes.
prepare_input()[source]
prepare input parameters for C++ code.
run(par={}, x0=None, verbose=False)[source]
Integrate the system of equations for Jansen-Rit model.
check_sequence(x, n)[source]
check if x is a scalar or a sequence of length n

Parameters:
x: scalar or sequence of length n
n: number of nodes
Returns:
x: sequence of length n
set_initial_state(nn, seed=None)[source]
set initial state for the system of JR equations with N nodes.

Parameters:
nn: number of nodes
seed: random seed
Returns:
y: initial state of length 6N
vbi.models.cpp.km

class KM_sde(par)[source]
Kuramoto model with noise (sde), C++ implementation.

Parameters:
pardict
Dictionary of parameters.
valid_parameters = ['G', 'dt', 'noise_amp', 'omega', 'weights', 'noise_seed', 'seed', 'alpha', 't_initial', 't_transition', 't_end', 'output', 'num_threads', 'initial_state', 'type']
set_initial_state()[source]
get_default_parameters()[source]
check_parameters(par)[source]
prepare_input()[source]
run(par={}, x0=None, verbose=False)[source]
Simulate the model.

Parameters:
pardict
Dictionary of parameters.
x0array
Initial state.
verbosebool
Print simulation progress.
Returns:
dict
tarray
Time points.
xarray
State time series.
set_initial_state(num_nodes, seed=None)[source]
vbi.models.cpp.mpr

class MPR_sde(par: dict = {}, parbold={})[source]
MPR model

set_initial_state()[source]
check_parameters(par: dict)[source]
get_default_parameters()[source]
prepare_input()[source]
Prepare input parameters for passing to C++ engine.
run(par: dict = {}, x0: ndarray | None = None, verbose: bool = False)[source]
Integrate the MPR model with the given parameters.

Parameters:
pardict
Dictionary of parameters.
x0array_like
Initial condition of the system.
verbosebool
If True, print the progress of the simulation.
Returns:
boldarray_like
Simulated BOLD signal.
class BoldParams(par={})[source]
check_parameters(par)[source]
get_default_parameters()[source]
get_params()[source]
check_sequence(x: int | float | ndarray, n: int)[source]
check if x is a scalar or a sequence of length n

Parameters:
x: scalar or sequence of length n
n: number of nodes
Returns:
x: sequence of length n
set_initial_state(nn, seed=None)[source]
vbi.models.cpp.vep

class VEP(par: dict = {})[source]
Virtual Epileptic Patient (VEP) model

set_initial_state()[source]
check_parameters(par: dict)[source]
prepare_input()[source]
get_default_parameters()[source]
run(par: dict = {}, x0: ndarray | None = None, verbose: bool = False)[source]
set_initial_state(nn: int, seed: int | None = None)[source]
check_sequence(x: int | float | ndarray, n: int)[source]
check if x is a scalar or a sequence of length n

Parameters:
x: scalar or sequence
n: number of elements
Returns:
x: sequence of length n
vbi.models.cpp.wc

class WC_ode(par={})[source]
References:

[WC_1972](1,2)
Wilson, H.R. and Cowan, J.D. Excitatory and inhibitory interactions in localized populations of model neurons, Biophysical journal, 12: 1-24, 1972.
[WC_1973]
Wilson, H.R. and Cowan, J.D A Mathematical Theory of the Functional Dynamics of Cortical and Thalamic Nervous Tissue
[D_2011]
Daffertshofer, A. and van Wijk, B. On the influence of amplitude on the connectivity between phases Frontiers in Neuroinformatics, July, 2011
Used Eqns 11 and 12 from [WC_1972] in rhs. P and Q represent external inputs, which when exploring the phase portrait of the local model are set to constant values. However in the case of a full network, P and Q are the entry point to our long range and local couplings, that is, the activity from all other nodes is the external input to the local population [WC_1973], [D_2011] .

The default parameters are taken from figure 4 of [WC_1972], pag. 10.

check_parameters(par)[source]
get_default_parameters()[source]
set_initial_state(seed=None)[source]
prepare_input()[source]
run(par={}, x0=None, verbose=False)[source]
Integrate the system of equations for the Wilson-Cowan model.

Parameters:
pardict
Dictionary with parameters of the model.
x0array-like
Initial state of the system.
verbosebool
If True, print the integration progress.
check_sequence(x, n)[source]
check if x is a scalar or a sequence of length n

Parameters:
x: scalar or sequence of length n
n: number of nodes
Returns:
x: sequence of length n
Cupy models
vbi.models.cupy.mpr

class Bold(par: dict = {})[source]
get_default_parameters()[source]
get balloon model parameters.
update_dependent_parameters()[source]
check_parameters(par)[source]
allocate_memory(xp, nn, ns, n_steps, bold_decimate, dtype)[source]
do_bold_step(r_in, dtt)[source]
class MPR_sde(par: dict = {}, Bpar: dict = {})[source]
Montbrio-Pazo-Roxin model Cupy and Numpy implementation.

Parameters:
G: float. np.ndarray
global coupling strength
dt: float
time step
dt_bold: float
time step for Balloon model
J: float, np.ndarray
model parameter
eta: float, np.ndarray
model parameter
tau:
model parameter
delta:
model parameter
tr: float
repetition time of fMRI
noise_amp: float, np.array
amplitude of noise
same_noise_per_sim:
same noise for all simulations
iapp: float, np.ndarray
external input
t_start: float
initial time
t_cut: float
transition time
t_end: float
end time
num_nodes: int
number of nodes
weights: np.ndarray
weighted connection matrix
rv_decimate: int
sampling step from r and v
output: str
output directory
RECORD_TS: bool
store r and v time series
num_sim: int
number of simulations
method: str
integration method
engine: str
cpu or gpu
seed: int
seed for random number generator
dtype: str
float or f
initial_state: np.ndarray
initial state
same_initial_state: bool
same initial state for all simulations
set_initial_state()[source]
get_default_parameters()[source]
update_dependent_parameters()[source]
check_parameters(par)[source]
prepare_input()[source]
f_mpr(x, t)[source]
MPR model
heunStochastic(y, t, dt)[source]
Heun scheme to integrate MPR model with noise.
sync_(engine='gpu')[source]
run(verbose=True)[source]
set_initial_state(nn, ns, engine, seed=None, same_initial_state=False, dtype=<class 'float'>)[source]
Set initial state

Parameters:
nnint
number of nodes
nsint
number of simulations
enginestr
cpu or gpu
same_initial_conditionbool
same initial condition for all simulations
seedint
random seed
dtypestr
float: float64 f : float32
vbi.models.cupy.ghb

vbi.models.cupy.jansen_rit

class JR_sde(par: dict = {})[source]
Jansen-Rit model cupy implementation.

Parameters
Name
Explanation
Default Value
A
Excitatory post synaptic potential amplitude.
3.25
B
Inhibitory post synaptic potential amplitude.
22.0
1/a
Time constant of the excitatory postsynaptic potential.
a: 0.1 (1/a: 10.0)
1/b
Time constant of the inhibitory postsynaptic potential.
b: 0.05 (1/b: 20.0)
C0, C1
Average numbers of synapses between excitatory populations. If array-like, it should be the shape of (num_nodes, num_sim).
C0: 1.0 * 135.0, C1: 0.8 * 135.0
C2, C3
Average numbers of synapses between inhibitory populations. If array-like, it should be the shape of (num_nodes, num_sim).
C2: 0.25 * 135.0, C3: 0.25 * 135.0
vmax
Maximum firing rate
0.005
v
Potential at half of maximum firing rate
6.0
r
Slope of sigmoid function at v_0
0.56
G
Scaling the strength of network connections. If array-like, it should of length num_sim.
1.0
mu
Mean of the noise
0.24
noise_amp
Amplitude of the noise
0.01
weights
Weight matrix of shape (num_nodes, num_nodes)
None
num_sim
Number of simulations
1
dt
Time step
0.01
t_end
End time of simulation
1000.0
t_cut
Cut time
500.0
engine
“cpu” or “gpu”
“cpu”
method
“heun” or “euler” method for integration
“heun”
seed
Random seed
None
initial_state
Initial state of the system of shape (num_nodes, num_sim)
None
same_initial_state
If True, all simulations have the same initial state
False
same_noise_per_sim
If True, all simulations have the same noise
False
decimate
Decimation factor for the output time series
1
dtype
Data type to use for the simulation, float for float64 or f for float32.
“float”
check_parameters(par)[source]
Check if the provided parameters are valid.

Parameters:
pardict
Dictionary of parameters to check.
Raises:
ValueError
If any parameter in par is not valid.
set_initial_state()[source]
get_default_parameters() → dict[source]
Default parameters for the Jansen-Rit model

Parameters:
nnint
number of nodes
Returns:
paramsdict
default parameters
prepare_input()[source]
Prepare input parameters for the Jansen-Rit model.
S_(x)[source]
Compute the sigmoid function.

This function calculates the sigmoid of the input x using the parameters vmax, r, and v0.

Parameters:
xfloat or array-like
The input value(s) for which to compute the sigmoid function.
Returns:
float or array-like
The computed sigmoid value(s).
f_sys(x0, t)[source]
Compute the derivatives of the Jansen-Rit neural mass model.

Parameters:
x0array_like
Initial state vector of the system. It should have a shape of (6*nn, ns), where nn is the number of neurons and ns is the number of simulations.
tfloat
Current time point (not used in the computation but required for compatibility with ODE solvers).
Returns:
dxarray_like
Derivatives of the state vector. It has the same shape as x0.
The function computes the derivatives of the state vector based on the Jansen-Rit model equations.
euler(x0, t)[source]
Perform one step of the Euler-Maruyama method for stochastic differential equations.

Parameters:
x0array_like
The initial state of the system.
tfloat
The current time.
Returns:
array_like
The updated state of the system after one Euler step.
heun(x0, t)[source]
Perform a single step of the Heun’s method for stochastic differential equations.

Parameters:
x0ndarray
The initial state of the system.
tfloat
The current time.
Returns:
ndarray
The updated state of the system after one Heun step.
run(x0=None)[source]
Simulate the Jansen-Rit model.

Parameters:
x0: array [num_nodes, num_sim]
initial state
Returns:
dict: simulation results
t: array [n_step]
time
x: array [n_step, num_nodes, num_sim]
y1-y2 time series
set_initial_state(nn, ns, engine, seed=None, same_initial_state=False, dtype='float')[source]
set initial state for the Jansen-Rit model

Parameters:
nn: int
number of nodes
ns: int
number of simulations
engine: str
cpu or gpu
seed: int
random seed
same_initial_state: bool
if True, all simulations have the same initial state
dtype: str
data type
Returns:
y0: array [nn, ns]
initial state
vbi.models.cupy.utils

get_module(engine='gpu')[source]
Switches the computational engine between GPU and CPU.

Parameters:
enginestr, optional
The computational engine to use. Can be either “gpu” or “cpu”. Default is “gpu”.
Returns:
module
The appropriate array module based on the specified engine. If “gpu”, returns the CuPy module. If “cpu”, returns the NumPy module.
Raises:
ValueError
If the specified engine is not “gpu” or “cpu”.
If CuPy is not installed.
tohost(x)[source]
move data to cpu if it is on gpu

Parameters:
x: array
data
Returns:
array
data moved to cpu
todevice(x)[source]
move data to gpu

Parameters:
x: array
data
Returns:
array
data moved to gpu
is_on_cpu(x)[source]
Check if input is on CPU (i.e., not a CuPy array)

Parameters:
x: any
Input to check
Returns:
bool
True if input is not a CuPy array (i.e., is on CPU), False otherwise
is_on_gpu(x)[source]
Check if input is on GPU (i.e., is a CuPy array)

Parameters:
x: any
Input to check
Returns:
bool or None
True if input is a CuPy array (i.e., is on GPU) False if input is not a CuPy array None if CuPy is not installed
move_data(x, engine)[source]
repmat_vec(vec, ns, engine)[source]
repeat vector ns times

Parameters:
vec: array 1d
vector to be repeated
ns: int
number of repetitions
engine: str
cpu or gpu
Returns:
vec: array [len(vec), n_sim]
repeated vector
is_seq(x)[source]
check if x is a sequence

Parameters:
x: any
variable to be checked
Returns:
bool
True if x is a sequence
prepare_vec(x, ns, engine, dtype='float')[source]
check and prepare vector dimension and type

Parameters:
x: array 1d
vector to be prepared, if x is a scalar, only the type is changed
ns: int
number of simulations
engine: str
cpu or gpu
dtype: str or numpy.dtype
data type to convert to
Returns:
x: array [len(x), n_sim]
prepared vector
prepare_vec_1d(x, ns, engine, dtype='float')[source]
check and prepare vector dimension and type
get_(x, engine='cpu', dtype='f')[source]
Parameters:
xarray-like
The input array to be converted.
enginestr, optional
The computation engine to use. If “gpu”, the array is transferred from GPU to CPU. Defaults to “cpu”.
dtypestr, optional
The desired data type for the output array. Defaults to “f”.
Returns:
array-like
The converted array with the specified data type.
dtype_convert(dtype)[source]
Convert a string representation of a data type to a numpy dtype.

Parameters:
dtypestr
The string representation of the data type (e.g., “float”, “float32”, “float64”).
Returns:
numpy.dtype
The corresponding numpy dtype.
Raises:
ValueError
If the input string does not match any known data type.
prepare_vec_2d(x, nn, ns, engine, dtype='float')[source]
if x is scalar pass if x is 1d array, shape should be (ns,) if x is 2d array, shape should be (nn, ns)

# Probabilistic Integrated Gas and Electricity Network Model (P-IGEN)

P-IGEN is a probabilistic model for integrated gas and electricity networks considering the input uncertainty associated with gas demand, electricity demand and wind generation. First, the correlated uncertainty of electricity and gas demand are modelled using the copula method, while wind generation uncertainty is modelled using kernel density estimation. Then, the optimisation problem is formulated as an interdependent steady-state optimal power and natural gas flow, which is iterated using the non-sequential Monte Carlo method to capture the input uncertainty. Finally, the effectiveness of the proposed model is demonstrated through the assessment of heat electrification impacts on Great Britain’s electricity and gas networks. While the case study is based on Great Britain, the modelling framework can be applied to other networks. The use of P-IGEN model requires familiarity with basic operations of MATLAB. 

### System Requirements
MATLAB version 7.3 (R2016b) or later

[MATPOWER](https://github.com/MATPOWER/matpower) version 7.0 or later.

[MPNG](https://github.com/MATPOWER/MPNG)

[IPOPT](https://github.com/coin-or/Ipopt)

### Citing GB-IGEN model
We do request that publications derived from the use of P-IGEN model explicitly acknowledge that fact by including the following cite:

A. Ehsan and R.Preece, "P-IGEN: Probabilistic Integrated Gas and Electricity Network Model," 2023. [Online]. Available: https://github.com/Ali-Ehsan-UoM/P-IGEN

*See that a journal publication to appear soon should be cited instead.


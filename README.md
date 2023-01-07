# Handy Codes Repositry
###### This Repositry contains many codes that may facilitate or ease-up simple tasks that takes time from any researcher or user.


### List of codes or Programs:
1. ModBasesScanner
2. Michaelis-Menten-Kinetics




## 1.ModBasesScanner
##### This code is used to know wether a file has any modified bases or not (used for RNA PDB files) as it runs through all the PDB files in a directory and generates a CSV file containing all the modified bases, their location, PDB ID, and the location of the modification within the PDB structure. 

***Code is written in Python***

##### Needed Packages:
- NumPy
- Pandas
- CSV
- OS

## 2.Michaelis-Menten-Kinetics
#### This code is used to predict the enzymatic activity of a specific enzyme acting on a specific substrate. The generated Kd or Ka are according to the predicted value of the binding affinity by the HADDOCK tool named PRODIGY. Then the value of Gibbs free energy is used to calculate the Keq. The server also predicts the Kd, then we use both values of Kd and Keq to predict the Ka. The whole relation between the enzyme activity and substrate concentration is illustrated by two graphs, including the linear realtionship (Line weaver-Burk Plot).

***Code is written in MATLAB***

##### Needed Givens:
- Kd (Dissociation Constant).
- dG (Gibbs Free energy).
- Kcat (Catalytic rate of degradation of the enzyme).
- Range of enzyme concentrations you will be using.
- The concentration of substrate.

##### Calculated Values:
- Vmax (Maximum rate of the reaction).
- Km (Michaelis-Menten Constant).
- v (Rate of the reaction).

##### Built-in constants:
- Boltzmann Constant.
- Planck Constant.
- Temperature (310 Kelvin).
- General Gas Constant.


clear
format compact
%Defining the constants to use forward in the model.
boltzmann_constant = (1.380649)*(10^-23);
planck_constant = (6.62607015) * (10^34);
Temp = 310;
general_gas_constant = 8.3144598;

%Gathering our input parameters
question1 = input("Do you have the value of dissociation constant (Kd)? If yes type 1, if not type 2 ---> ");
kd = {};
if question1 == 1
    k_d_input = input("Enter the value of of dissociation constant. Enter the value between a []");
    kd{end+1} = k_d_input;
else
    error("You can get the value of Kd and gibbs free energy for your docked from the following link: https://wenmr.science.uu.nl/prodigy/")
end
question2 = input("Do you have the value of gibbs free energy? type 1, if not type 2");
gibbs = {};
if question2 == 1
    gibbs_input = input("Enter the value of gibbs free energy. Enter the value between a []");
    gibbs{end+1} = gibbs_input;
else
    error("You can get the value of Kd and gibbs free energy from the following link: https://wenmr.science.uu.nl/prodigy/")
end
question3 = input("Do you have the value of catalytic rate of degradation? If yes type 1, if not type 2.");
%k_c = {};
if question3 == 1
    k_c = input("Enter the value of the catalytic rate of degradation");
else
    error("You have to get the value of catalytic rate constant in order to proceed")
end

%Generating the other required inputs
k_eq = exp((gibbs{1,1})./(-general_gas_constant*Temp));
disp("The value of equillibirum constant is: " + k_eq)
ka = kd{1,1}./k_eq;
disp("The value of association constant is: " + ka)

%First half which calculates the rate of association and dissociation of
%the enzyme-substrate complex.
initial_Enzyme_array = {};
initial_Enzyme_start = input("Enter the initial concentration of the enzyme. The lowest value in the range");
initial_Enzyme_end = input("Enter the initial concentration of the enzyme. The highest value in the range");
%enzyme_conc_spacing = input("Enter the value you wish to be as a spacing between the highest and lowest values in the range of initial enzyme concentrations");
initial_Enzyme = linspace(initial_Enzyme_start, initial_Enzyme_end, 100);
initial_Enzyme_array{end+1} = initial_Enzyme;
disp("Range of initial concentrations of the enzyme is: " + initial_Enzyme)
%initial_Enzyme{end+1} = initial_Enzyme_input;
initial_substrate_array = {};
initial_substrate_start = input("Enter the initial concentration of the substrate. The lowest value in the range");
initial_substrate_end = input("Enter the initial concentration of the substrate. The highest value in the range");
%substrate_conc_spacing = input("Enter the value you wish to be as a spacing between the highest and lowest values in the range of initial substrate concentrations");
initial_substrate = linspace(initial_substrate_start, initial_substrate_end, 100);
initial_substrate_array{end+1} = initial_substrate;

%The value of Enzyme-Substrate complex will be calculated
disp("The value of Enzyme-Substrate complex will be calculated")
ES = ((ka) * (initial_Enzyme_array{1,1}.*initial_substrate_array{1,1}))./((ka) .* (initial_substrate_array{1,1})+kd{1,1});

%Now with the final part, we are going to calculate the rate and the
%maximum rate of the equation
v_max = {};
km = {};
v_max_result = k_c .* initial_Enzyme_array{1};
v_max{end+1} = v_max_result;
question4 = input("Do you have the value of Km? If yes type 1, if not type 2.");
if question4 == 1
    km_input = input("Enter the value of Km of the enzyme between []");
    km{end+1} = km_input;
else
    km{end+1} = ((kd{1,1} + k_c)./(ka));
end
%Now we will calculate the rate
rate = {};
rate_calculate = ((v_max{1,1}.*initial_substrate_array{1,1})./((km{1,1}) + initial_substrate_array{1,1}));
rate{end+1} = rate_calculate;
disp("The values of velocity of the reaction are: " + rate{1,1})

%Plotting functions
plot((1./rate{1,1}),(1./initial_substrate_array{1,1}),'b')
xlabel('The concentration of substrate [Amyloid-Beta] (Microgram/millilitre)') 
ylabel('Velocity of the reaction [v] (Microgram/minute)') 
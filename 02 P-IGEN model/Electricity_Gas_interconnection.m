#Case file for GB-networks interconnection

function connect = connect_pg_case9

% Input necessary to connect power and natural gas systems
connect.version = '1'; 

%vector to define the number of nt periods to be considered in the power system. 
%Each component in the vector represents the number of hours for each period such that sum(power.time)=24
connect.power.time =  [];

%matrix to define the active power demand for nb buses over nt periods of time.
connect.power.demands.pd = [     
%          0         0         0         0;
%          0         0         0         0;
%          0         0         0         0;
%          0         0         0         0;
%    45.0000   67.5000   90.0000  112.5000;
%          0         0         0         0;
%    50.0000   75.0000  100.0000  125.0000;
%          0         0         0         0;
%    62.5000   93.7500  125.0000  156.2500;
   ];  

%matrix to define the reactive power demand for nb buses over nt periods of time.
connect.power.demands.qd = [
%          0         0         0         0;
%          0         0         0         0;
%          0         0         0         0;
%          0         0         0         0;
%    -15.0000   -22.5000   -30.0000   -37.5000;
%          0         0         0         0;
%    17.5000   26.2500   35.0000   43.7500;
%          0         0         0         0;
%    25.0000   37.5000   50.0000   62.5000;   
];

% % cost for non-suplied power demand
connect.power.cost = 5000; 

% matrix to define the spinning reserve of na areas over nt periods
connect.power.sr = [                            
%     220 40  50  70;
%     50 10  60  10;
    ];

%   matrix to define the maximum energy MWh available for the ngh (subset of ng) hydroelectric power generators
connect.power.energy = ...
    [
%     1   24*100;
%     2   24*100;
    ];


%% ---------------------- Matpower gas case version ----------------------

%% power-driven compressor connected to bus
%  idcomp      bus
% connect.interc.comp =  [2   5];    
connect.interc.comp =  [];     

%% gas-fired unit connected to node
%   idgen	node    eff   
% locations based on  M.Cahudry et al. Energy Policy 62(2013) pp.473-483 (1mcm/d=34.11mmscfd)

connect.interc.term =  [        
4	2	10e-3                          % with  serial numbers of ccgt according to mpc.gen
13	23	10e-3 
18	22	10e-3 
23	6	10e-3 
26	7	10e-3 
31	21	10e-3 
33	20	10e-3 
34	44	10e-3 
36	42	10e-3
42	18	10e-3 
45	34	10e-3 
50	17	10e-3 
52	13	10e-3 
57	12	10e-3 
58	16	10e-3 
60	35	10e-3 
70	15	10e-3 
76	14	10e-3 

47	34	10e-3 % ocgt eff eq. to 0.33
54	13	10e-3 
59	16	10e-3 
71	15	10e-3 
78	14	10e-3 
];

% update ccgt eff      [10e-3/2.12 because 0.7/0.33=2.12 ]
connect.interc.term(1:18,3)=4.7e-3; %eq. to 0.7

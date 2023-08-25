% Main file to simulate P- IGEN model

% Load Network data for GB networks
mpc = Electricity_Network; %Load Electricity Network
mgc = Gas_Network; % Load Gas Network
connect = Electricity_Gas_interconnection; % Load interconnection case (it mainly has to fit with the MPC case based on 23 gas turbine interconnections)

% update GB networks data
connect = UpdateConnect(mpc, connect);
mgc=UpdateMGC(mgc);
mpc=UpdateMPC(mpc);    

%  initiate sample output matrices
output.PowerFlow=zeros(size(mpc.branch,1),1);
output.GasFlow=zeros(size(mgc.pipe,1),1);

% define MATPOWER option vector
mpopt = mpoption;                   % initialize option struct
mpopt.opf.ac.solver = 'ipopt';      % current stable sover
mpopt.ipopt.opts.max_iter = 1e4;    % max iterations
mpopt.ipopt.opts.tol = 1e-2;    % tolerance

% put all together
mpgc = mpc;                         % initialize MPNG case
mpgc.mgc = mgc;                     % adding gas case
mpgc.connect = connect;             % adding connection struct

% run program
res = mpng_modif(mpgc,mpopt);             % running MPNG

% save outputs
output.PowerFlow(:,1)=sqrt(res.branch(:,PF).^2+res.branch(:,QF).^2); %power flows in MVA
output.GasFlow(:,1)= res.mgc.pipe(:,3);  % gas flows in mmscfd



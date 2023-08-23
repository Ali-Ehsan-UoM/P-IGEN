%% Update gas demand, pipeline capacities and well capacities

function [mgc] = UpdateMGC(mgc)

define_constants_gas            % natural gas system and connect struct constants
GDfactor=2.01;  % make GD eq. to ndm2015-20 max total increases to 10650 from 4900 mmscfd)
GasWellFactor=1.5;
MaxPipeFlow=1600;

% adjust nodal gas demand
mgc.node.info(:,GD)=GDfactor*mgc.node.info(:,GD);
mgc.node.dem=GDfactor*mgc.node.dem;

%adjust supply from gas wells
mgc.well(:,4)=GasWellFactor*mgc.well(:,4);

%adjust pipeline max and min flows
mgc.pipe(:,7)=MaxPipeFlow;      
mgc.pipe(:,8)=-MaxPipeFlow;   

%adjust compressor max flow
mgc.comp(:,13)=MaxPipeFlow;    

end


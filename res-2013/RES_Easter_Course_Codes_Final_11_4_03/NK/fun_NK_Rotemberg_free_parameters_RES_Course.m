% ------------------------------------------------------
% This program defines the conditions needed to find the
% steady state value of hours worked using fsolve
% ------------------------------------------------------

function y=fun_NK_Rotemberg_RES_Course(x,PIE)

global M_
 
%% DO NOT CHANGE THIS PART.
%%
%% Here we load the values of the deep parameters in a loop.
%%
NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end                                                           % End of the loop.  
check = 0;
%%

%%Define hours as unknown
h=exp(x(1))/(1+exp(x(1)));
hF=exp(x(2))/(1+exp(x(2)));

%Define only the steady state relationships needed to find the value of hours worked that supports
%the resource constraint relationship Y=C+I+G

%h=hss;
A=Ass;
Rex=(1+g)^((1-varrho)*(sigma_c-1)+1)/betta;
DD=1/Rex;
%%%%%%%%%%%PWP=1-1/zzeta;
MC=1-(1-ppsi*(PIE-1)*PIE*(1-DD*(1+g)))/zzeta;
PWP=MC;

KY=(1-alp)*PWP/(Rex-1+delta)*(1+g);

%%%%%%%%%%%YW=A*h*KY^((1-alp)/alp);
YW=A*h*(KY/(1+g))^((1-alp)/alp);

K=KY*YW;
I=(delta+g)*K/(1+g);
Y=(1-c)*YW;
G=gy*Y;
WP=alp*PWP*YW/h;
C=WP*((1-varrho)*(1-h))/((1-hab/(1+g))*varrho);
tax=G/(WP*h);
%
%Flexi-Price 
%
RexF=Rex;
MCF=(1-1/zzeta);
PWPF=MCF;

KYF=(1-alp)*PWPF/(RexF-1+delta)*(1+g);

YWF=A*hF*(KYF/(1+g))^((1-alp)/alp);

KF=KYF*YWF;
IF=(delta+g)*KF/(1+g);
YF=(1-c)*YWF;
GF=gy*YF;
WPF=alp*PWPF*YWF/hF;
CF=WPF*((1-varrho)*(1-hF))/((1-hab/(1+g))*varrho);
taxF=GF/(WPF*hF);

%Resource constraint 
%this is the equation for which fsolve will find the solution
y=[Y-C-I-G-ppsi/2*(PIE-1)^2*Y; YF-CF-IF-GF];




%compute the steady state of NK Model 

function [ys,check]=GK_RES_Course_steadystate(ys,exe);
global M_
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%% THIS BLOCK IS MODEL SPECIFIC.
%%
%% Here the user has to define the steady state.
%%



%This part calls the function fun_RBC.m
 %Use fsolve to find the steady state values of hours worked
 %initial values
%PIE=1.0;
Stochg=g;
PIE=PIEss;
PIETILDE=PIE^(1-gamp);
%
%This part calls the function fun_RBC.m
 %Use fsolve to find the steady state values of hours worked
 %initial values
x0=[0.0;  5.0; 0.0; 0.0;0.0; log(0.99/(1-0.99))];

%x0 =[2.0687; 6.2350; 0.4121; 0.0033; -0.5795; 6.3930];

[x,fval] =fsolve(@fun_GK_RES_Course,x0,optimset('Display','off'),PIE);
%
%to reset initial values uncomment:
%x
%pause
%
%and replace x0 above

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Derived variables 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varrho=exp(x(1))/(1+exp(x(1)));
K=x(2);
ThetaB=exp(x(3))/(1+exp(x(3)));
xiB=x(4);
hF=exp(x(5))/(1+exp(x(5)));
betta=exp(x(6))/(1+exp(x(6)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=hss;
A=Ass;
Rn=Rnss;
Rex=Rn/PIE;
DD=1/Rex;
Delta=((1-xi)*(((1-xi*PIETILDE^(zzeta-1))/(1-xi))^(1/(1-zzeta)))^(-zzeta))/(1-xi*PIETILDE^zzeta);
MC=(1-1/zzeta)*(1-xi*betta*PIETILDE^zzeta*(1+g)^((1-varrho)*(1-sigma_c)))...
/(1-xi*betta*PIETILDE^(zzeta-1)*(1+g)^((1-varrho)*(1-sigma_c)))*(((1-xi*PIETILDE^(zzeta-1))...
/(1-xi))^(1/(1-zzeta)));
PWP=MC;
YW=(A*h)^(alp)*(K/(1+g))^(1-alp)/Delta;
I=(delta+g)*K/(1+g);
Y=(1-c)*YW;
G=gy*Y;
WP=alp*PWP*YW/h;
C=WP*((1-varrho)*(1-h))/((1-hab/(1+g))*varrho);
tax=G/(WP*h);
%Post recursive Steady state relationship
LAMBDA=1/(1-sigma_c)*((C*(1-hab/(1+g)))^((1-varrho)*(1-sigma_c))*(1-h)^(varrho*(1-sigma_c))-1);
LAMBDAC=(1-varrho)*((C*(1-hab/(1+g)))^((1-varrho)*(1-sigma_c)-1)*(1-h)^(varrho*(1-sigma_c)));
XX=(Rex)*LAMBDAC;
Q=1;
X=1+g;
Z1=2.0*phiX*(X-1-g)*X^2*Q/(Rex);
Z2=(1-alp)*PWP*YW/(K/(1+g))+(1-delta)*Q;
%
%
H=Y*LAMBDAC/(1-betta*xi*PIETILDE^(zzeta-1)*(1+g)^((1-varrho)*(1-sigma_c)));
Htilde=(PIETILDE^(zzeta-1))*H;
J=(1/(1-1/zzeta))*Y*LAMBDAC*MC/(1-betta*xi*PIETILDE^(zzeta)*(1+g)^((1-varrho)*(1-sigma_c)));
Jtilde=PIETILDE^zzeta*J;

INVPIE=1/PIE;

%
%Banks
%
S=K;
Z=(1-alp)*PWP*YW/(K/(1+g));
phiB=lev;
NW=(Q*S)/phiB;
Dep=(Q*S)-NW;
omega=1-sigmaB+sigmaB*ThetaB*phiB;
nuB=omega;
muB=(phiB*ThetaB-nuB)/phiB;
Rk=muB/(DD*omega)+Rex;
spread=Rk-Rex;
%End banks


YY=1;
CC=1;
hh=1;
WPWP=1; 
II=1; 
KK=1;
RR=1;
RnRn=1;
QQ=1;
PIEPIE=1;
NWNW=1;
muBmuB=1;
RkRk=1;
spreadspread=RkRk-RR;
MS=1;
MPS=1;
ZRn=Rn;

%
%Flexi-Price ss
%

RF=Rex;
MCF=(1-1/zzeta);
PWPF=MCF;
KYF=(1-alp)*PWPF/(RF-1+delta)*(1+g);


YWF=A*hF*(KYF/(1+g))^((1-alp)/alp);

KF=KYF*YWF;
IF=(delta+g)*KF/(1+g);
YF=(1-c)*YWF;
WPF=alp*PWPF*YWF/hF;
CF=WPF*((1-varrho)*(1-hF))/((1-hab/(1+g))*varrho);
GF=YF*G/Y;
taxF=GF/(WPF*hF);

LAMBDAF=1/(1-sigma_c)*((CF*(1-hab/(1+g)))^((1-varrho)*(1-sigma_c))*(1-hF)^(varrho*(1-sigma_c))-1);
LAMBDACF=(1-varrho)*((CF*(1-hab/(1+g)))^((1-varrho)*(1-sigma_c)-1)*(1-hF)^(varrho*(1-sigma_c)));

QF=1;
XF=1+g;
Z1F=2.0*phiX*(XF-1-g)*XF^2*QF/(RF);
Z2F=(1-alp)*PWPF*YWF/(KF/(1+g))+(1-delta)*QF;


RkF=RF; 
spreadF=0; 
RRF=1;
YYF=1;
CCF=1;
hhF=1;
WPWPF=1;
IIF=1;
KKF=1;

QQF=1;
DDF=DD;
DDL=DD;
DDFL=DDF;

XXF=1;
OUTGAP=YF/Y;
OUTGAPOUTGAP=1;
capqual=1;
phiphi=1;
dy=trend;
pinfobs=log(PIEPIE)+conspie;
robs=log(RnRn)+consr;
rkn_obs = log(RkRk*PIEPIE)+consrkn;


%% END OF THE MODEL SPECIFIC BLOCK.


%% DO NOT CHANGE THIS PART.
%%
%% Here we define the steady state vZNues of the endogenous variables of
%% the model.
%%
NumberOfEndogenousVariables = M_.endo_nbr;                    % Number of endogenous variables.
ys = zeros(NumberOfEndogenousVariables,1);                    % Initialization of ys (steady state).
for i = 1:NumberOfEndogenousVariables                         % Loop...
  varname = deblank(M_.endo_names(i,:));                      %    Get the name of endogenous variable i.                     
  eval(['ys(' int2str(i) ') = ' varname ';']);                %    Get the steady state vZNue of this variable.
end                                                           % End of the loop.
%%


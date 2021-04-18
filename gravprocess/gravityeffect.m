function totaleffect=gravityeffect(h0,s0,p0,tl,amp,phs)
%
%     purpose:  To compute the gravity effect due to each        
%               tidal component.
%
dtor = pi/180;
R90 = pi/2;          
R360 = pi*2;
%
p0 = rem(p0,R360);
h0 = rem(h0,R360);
s0 = rem(s0,R360);
tl = rem(tl,R360);
%
% argument                     component
arg(1) = 2*tl - 2*s0;          % M2
arg(2) = 2*tl - 2*h0;          % S2
arg(3) = tl - R90;             % K1
arg(4) = tl - 2*s0 + R90;      % O1
arg(5) = 2*tl - 3*s0 + p0;     % N2
arg(6) = tl - 2*h0 + R90;      % P1
arg(7) = 2*tl;                 % K2
arg(8) = tl - 3*s0 + p0 +R90;  % Q1
arg(9) = 2*s0;                 % Mf
arg(10) = s0 - p0;             % Mm
arg(11) = 2*h0;                % Ssa
%
totaleffect=sum(amp.*cos(arg-phs*dtor));
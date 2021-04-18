function[ang, perp]=anglegravi(p1, p2, p3, Un)
% Angle.m finds the angle between planes O-p1-p2 and O-p2-p3, where
% p1,p2,p3 are coordinates of 3 points, taken in ccw order as seen from
% origin O. This is used by grvmag3d for finding the solid angle subtended
% by a polygon at the origin.
% Un is the unit outward normal vector to the polygon.
inout=sign(sum(Un .* p1)); % Check if face is seen from inside
x2=p2(1,1);
y2=p2(1,2);
z2=p2(1,3);
if inout==0
    ang=0;
    perp=1;
else
    if inout>0 % seen from inside; interchange p1 and p3
        x3=p1(1,1);
        y3=p1(1,2);
        z3=p1(1,3);
        x1=p3(1,1);
        y1=p3(1,2);
        z1=p3(1,3);
    end;
    if inout<0 % seen from outside; keep p1 and p3 as they are
        x1=p1(1,1);
        y1=p1(1,2);
        z1=p1(1,3);
        x3=p3(1,1);
        y3=p3(1,2);
        z3=p3(1,3);
    end;
    n1=[(y2*z1-y1*z2) (x1*z2-x2*z1) (x2*y1-x1*y2)]; % Normals
    n2=-[(y3*z2-y2*z3) (x2*z3-x3*z2) (x3*y2-x2*y3)];
    n1=n1./norm(n1);
    n2=n2./norm(n2);
    perp=sum([x3 y3 z3].*n1);
    % sign of perp is -ve if points p1 p2 p3 are in cw order
    perp=sign(perp);
    r=sum((n1.* n2));
    ang=acos(r);
    if perp<0
        ang=2*pi-ang;
    end;
end;
return;

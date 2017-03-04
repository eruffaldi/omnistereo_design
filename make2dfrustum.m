% along X axis
function R = make2dfrustum(fovDeg,nearPlane,farPlane)


afovRad = fovDeg/2*pi/180;

% r sin a = y
% r cos a = near
yhalfnear = nearPlane*tan(afovRad);
yhalffar = farPlane*tan(afovRad);

R = [nearPlane yhalfnear; farPlane yhalffar; farPlane -yhalffar; nearPlane -yhalfnear];


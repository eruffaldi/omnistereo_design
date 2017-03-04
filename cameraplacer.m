function r = cameraplacer(ncameras,stereoipd,camsize,innerradius)
%
% Lens size: 56.5 for 12mm, then 29.5 for (40.1+8.1 = 48.2)
% Camera size: 44 mm x 29 mm x 58 mm withouth the 8.1 of the lens holder
%
%
% TODO: camera matrix
% TODO: camera points

camerafov = [185,185]; % 8.6 mm diameter
focallength = 27; 
backfocaldistance = 9.7;
exitpupilposition = -49;
camspanradius = 300;

% minimum focus 0.2 from front of lens

lenssize1 = [29.5,48.2];
lenssize2 = [56.5,12];

if isempty(camsize)
    camsize = [44,58];
end

assert(length(camsize) == 2,'Camsize should be vector 2 size X Y');

xsize = camsize(1);
ysize = camsize(2);

% camera centered in middle
campts = [-xsize/2,-ysize/2,1;xsize/2,-ysize/2,1;xsize/2,ysize/2,1;-xsize/2,ysize/2,1; -xsize/2,-ysize/2,1];

% then the first part of lens
lxsize = lenssize1(1);
lysize = lenssize1(2);
lysize1 = lysize;
lenspts1 = [-lxsize/2,-lysize/2,1;lxsize/2,-lysize/2,1;lxsize/2,lysize/2,1;-lxsize/2,lysize/2,1; -lxsize/2,-lysize/2,1];

% offseted
lenspts1 = lenspts1 + repmat([0,ysize/2+lysize1/2,0],size(lenspts1,1),1);

% then second part of lens
lxsize = lenssize2(1);
lysize = lenssize2(2);
lenspts2 = [-lxsize/2,-lysize/2,1;lxsize/2,-lysize/2,1;lxsize/2,lysize/2,1;-lxsize/2,lysize/2,1; -lxsize/2,-lysize/2,1];

% offseted
lenspts2 = lenspts2 + repmat([0,ysize/2+lysize1+lysize/2,0],size(lenspts2,1),1);

lenstipy = ysize/2+lysize1+lysize/2;

% all points
allpts = [campts;NaN NaN 0; lenspts1;NaN NaN 0; lenspts2];



fovxrad = camerafov(1)*pi/180;

angles = (-fovxrad/2:0.05:fovxrad/2)';

viewpts = [0 lenstipy,1; camspanradius*sin(angles),camspanradius*cos(angles)+lenstipy,ones(length(angles),1);0 lenstipy,1; ];

viewpts =  [viewpts;NaN NaN NaN; 0 ,lenstipy ,1; 0 ,lenstipy+camspanradius,1];
%viewpts = applypoints(rotz(pi/2),viewpts);

assert(innerradius > xsize,'Radius is smaller than camera vertical size');



angles = linspace(0,2*pi,ncameras+1)';
angles = angles(1:end-1);

radius = innerradius;

poso = [radius*cos(angles), radius*sin(angles)];

matx = zeros(ncameras,3,3);

for I=1:ncameras
    m = rotz(angles(I));
    % then translate along the y direction
    m = m*rotztx(0,0,radius);
    matx(I,:,:) = m;
end


if stereoipd == 0
    pos = poso;
   
    isleft = ones(ncameras,1);
else
    assert(stereoipd > max(lenssize2(1),camsize(1)),'Seperation should be bigger than camera AND lens size');
    pos = zeros(ncameras*2,2);
    isleft = ones(ncameras*2,1);    
    omatx = matx;
    matx = ones(ncameras*2,3,3);
    for I=1:ncameras
        tdir = stereoipd/2*[-sin(angles(I)),cos(angles(I))];
        J = (I-1)*2+1;
        pos(J,:) = poso(I,:) - tdir;
        pos(J+1,:) = poso(I,:) + tdir;
        isleft((I-1)*2+2) = 0;
        
        % translate locally along the x axis
        m = squeeze(omatx(I,:,:));
        matx(J,:,:) = m *rotztx(0,-stereoipd/2,0);
        matx(J+1,:,:) = m *rotztx(0,stereoipd/2,0);
    end
end


r.allpoints = applypoints(matx,allpts);
r.viewpoints = applypoints(matx,viewpts);
r.centers = pos;
r.isleft  = isleft;
r.matx = matx;
if stereoipd > 0
    r.title = sprintf('%d cameras with %fmm ipd and radius %fmm',ncameras*2,stereoipd,innerradius);
else
    r.title = sprintf('%d cameras and radius %fmm',ncameras,innerradius);
end

function m = rotztx(alpha,x,y)

m = rotz(alpha);
m(1,3) = x;
m(2,3) = y;

function allpoints = applypoints(matx,allpts)

size(allpts)
allpoints = [];
if ndims(matx) == 3
    for I=1:size(matx,1)
        m = squeeze(matx(I,:,:));
        for J=1:size(allpts,1)
            p = m*allpts(J,:)';
            allpoints = [allpoints; p'];
        end    
        allpoints = [allpoints; NaN NaN NaN];
    end
else
    m = matx;
    for J=1:size(allpts,1)
            p = m*allpts(J,:)';
            allpoints = [allpoints; p'];
    end    
end


function m = rotz(alpha)

m = [cos(alpha) -sin(alpha), 0; sin(alpha) cos(alpha) 0; 0 0 1];
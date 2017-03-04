%run('/Users/eruffaldi/Documents/MatlabAddons/matGeom/setupMatGeom');
%addpath /Users/eruffaldi/Documents/MatlabAddons/PolygonClipper

%%

p = make2dfrustum(60,0.5,2.0);
R = make2drot(70*pi/180);

p1 = polytx([1 0 0.0; 0 1 0.6; 0 0 1],p);
p2 = polytx([1 0 0; 0 1 -0.6; 0 0 1],p);

p1 = polytx(R,p1);
p2 = polytx(R,p2);
p3 = polyclip(p1,p2,'&');


drawPolygon(p1, 'linewidth', 2,'Color','g');
hold on
drawPolygon(p2, 'linewidth', 2);
drawPolygon(p3,'linewidth',2,'Color','r');
hold off

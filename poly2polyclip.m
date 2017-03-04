function P = poly2polyclip(p)

P = [];
P.x = p(:,1)';
P.y = p(:,2)';
P.hole = 0;

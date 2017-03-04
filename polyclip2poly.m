function P = polyclip2poly(p,merge)

if nargin < 2
    merge = 0;
end

if length(p) > 1 & merge == 0
    error('Polygon has holes or disjoint patches');
end

if length(p) > 1 & merge == 1
    % build the convex 
    pts = [];
    for I=1:length(p)
        if p(I).hole == 0
            x = p(I).x;
            y = p(I).y;
            pts = [pts; x(:), y(:)];
        end
    end
    ii = convhull(pts(:,1),pts(:,2));
    P = [pts(ii,1),pts(ii,2)];
    return;
else
    if isempty(p)
        P = [];
    else
        x = p(1).x;
        y = p(1).y;
        P = [x(:),y(:)];
    end
end


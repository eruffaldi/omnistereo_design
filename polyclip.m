% 0..3 = - & ^ |
% 
% PolygonClip uses array of structures
function r = polyclip(p1,p2,type,outclip)

if ischar(type)
    switch type
        case '-'
            type = 0;
        case '&'
            type = 1;
        case '^'
            type = 2;
        case '|'
            type = 3;
        otherwise
            error('Unknown type expected: - & ^ |');
    end
end

if nargin < 4
    outclip = 0;
end

if isstruct(p1) == 0
    p1 = poly2polyclip(p1);
end

if isstruct(p2) == 0
    p2 = poly2polyclip(p2);
end

pr = PolygonClip(p1,p2,type);

if outclip == 1
    r = pr;
else
    r = polyclip2poly(pr);
end

function p = polytx(R,p)

if size(p,2) == 2
    p = [p, ones(size(p,1),1)];
end

r =  R*p'; % 3x3 3xn

p = r';

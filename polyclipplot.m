function polyclipplot(P)


if isstruct(P) == 0
    P = poly2polyclip(P);
end
for i=1:length(P)
    p = P(i);
%            eval(['p=P' num2str(i) ';'])
            for np=1:length(p)
                obj=patch(p(np).x,p(np).y,i);
                if p(np).hole==1; set(obj,'facecolor','w'); end
            end
        end
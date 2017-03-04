clear P1
clear P2
P1.x=[-1 1 1 -1]; P1.y=[-1 -1 1 1]; P1.hole=0;
P1(2).x=[-1 1 1 -1]*.5; P1(2).y=[-1 -1 1 1]*.5; P1(2).hole=1;

P2.x=[-2 0.8 0.4 -2]; P2.y=[-.5 -.2 0 .5]; P2.hole=0;
P2(2).x=[2 0.8 0.6 1.5]; P2(2).y=[-1 0 0.3 1]; P2(2).hole=0;

    
p1 = polyclip2poly(P1,1);
p2 = polyclip2poly(P2,1);
figure(1)
polyclipplot(p2);
figure(2)
polyclipplot(P2);

% TODO: calcolo raggi esterni 
% TODO: punto di avvitamento e calcolo punti
% TODO: struttura sotto 280x300
% TODO: buco dei cavi raggio x

%%
% r = cameraplacer(6,64,[],128);
hold off
scolors = 'rg';
%scatter(r.centers(:,1),r.centers(:,2),[],r.isleft,'filled');
plot(r.allpoints(:,1),r.allpoints(:,2))
hold on
plot(r.viewpoints(:,1),r.viewpoints(:,2),'g');
hold off
axis equal
title(r.title);

%%
r = cameraplacer(5,64,[],110);
hold off
scolors = 'rg';
%scatter(r.centers(:,1),r.centers(:,2),[],r.isleft,'filled');
plot(r.allpoints(:,1),r.allpoints(:,2))
hold on
%plot(r.viewpoints(:,1),r.viewpoints(:,2),'g');
hold off
axis equal
title(r.title);
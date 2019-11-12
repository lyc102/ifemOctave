close all; clear all;

node = [-1 -1; 1 -1; 1 1; -1 1];
elem = [2 3 1; 4 1 3];
%bdFlag = setboundary(node,elem,'Dirichlet','all');

for i = 1:2 % 
    [node,elem] = uniformbisect(node,elem);
end


nt = size(elem,1);
C  = find_centroid(node,elem);
h  = zeros(nt,1);
for i=1:nt
    if C(i,1) < 0.0
        h(i) = 0.5;
    else
        h(i) = 0.2;
    end
end

refineElem  = find( (C(:,1) > -0.3) .* (C(:,1) < 0.3));


clf(figure(1));
figure(1);
set(gcf,'Units','normal'); set(gcf,'Position',[0.0,0.4,0.3,0.5]);
showmesh(node,elem); view(2); xlabel('x'); ylabel('y');
findelem(node,elem); findnode(node);


% Do the bisection of the domain

fprintf('|refineElem| = %g \n',size(refineElem,1));
[node,elem,~,~,tree] = bisect(node,elem, refineElem);


ntn = size(elem,1);  %number of triangles after refinement
fprintf('refine ntn = %g \n',ntn);

h = eleminterpolate(h,tree);

% End Refinement ------------------------------------------------------

clf(figure(2));
figure(2);
set(gcf,'Units','normal'); set(gcf,'Position',[0.35,0.4,0.3,0.5]);
showmesh(node,elem); view(2); xlabel('x'); ylabel('y');
findelem(node,elem); findnode(node);


% Begin Coarsening ----------------------------------------------------
C  = find_centroid(node,elem);
coarsenElem = find( (C(:,1) < -0.3) + (C(:,1) > 0.3));


fprintf('|coarsenElem| = %g \n',size(coarsenElem,1));
[node,elem,~,~,tree] = coarsen(node,elem, coarsenElem, []);

clf(figure(3));
figure(3);
set(gcf,'Units','normal'); set(gcf,'Position',[0.7,0.4,0.3,0.5]);
showmesh(node,elem); view(2); xlabel('x'); ylabel('y');
findelem(node,elem); findnode(node);

ntn = size(elem,1);  %number of triangles after refinement
fprintf('coarsen ntn = %g \n',ntn);
fprintf('Before coarsen size(h) = %g \n',size(h,1));
fprintf('size(tree) = %g , %g \n',size(tree));

h = eleminterpolate(h,tree);
fprintf('After coarsen size(h) = %g \n',size(h,1));


fprintf('The size of h is wrong, it is 48 and should be 44 \n');

% Using the code from eleminterpolate we can fix up the size as follows. 

h(tree(:,3)) = [];

fprintf('After h(tree(:,3)) = [],  size(h) = %g \n',size(h,1));

% End Coarsen -----------------------------------------------------
         
  




%%
function C = find_centroid(node,elem)
x = (node(elem(:,1),1) + node(elem(:,2),1) + node(elem(:,3),1))/3;
y = (node(elem(:,1),2) + node(elem(:,2),2) + node(elem(:,3),2))/3;
C = [x,y]; %space initiation
end
     maxIt = 4;
     node = [1,0; 1,1; 0,1; -1,1; -1,0; -1,-1; 0,-1; 0,0]; % nodes
     elem = [1,2,8; 3,8,2; 8,3,5; 4,5,3; 7,8,6; 5,6,8];    % elements
     bdFlag = setboundary(node,elem,'Dirichlet');
     pde = mixBCdata;
     err = zeros(maxIt,1); 
     h = zeros(maxIt,1);
     for k = 1:maxIt
       [node,elem,bdFlag] = uniformrefine(node,elem,bdFlag);
       NT = size(elem,1);
       sigmaI = faceinterpolate(pde.Du,node,elem,'RT1');
%        err(k,1) = getL2errorBDM1(node,elem,pde.Du,sigmaI(1:end-2*NT));
%        sigmaI(end-2*NT+1:end) = 0;
       err(k,1) = getL2errorRT1(node,elem,pde.Du,sigmaI);
       h(k) = 1./(sqrt(size(node,1))-1);
     end
     figure;
     showrateh(h,err,2,'r-+','|| \sigma - \sigma_I ||');

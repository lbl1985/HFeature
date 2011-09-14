function [Hr,x] = drop_hankel_rank_hstln(Ab,maxiter)
% 
%  Drop the rank of a Hankel matrix by one using HSTLN technique
%
% Inputs:
%       Ab: m times n full column rank Hankel matrix
% Outputs:
%       Hr:  Reduced rank Hankel matrix
%        x:  vector of dimension (n-1) such that
%             [x 1] regressor associated with HR
%
%
%   Written by CD, 07/22/11 based on the paper:  
%   I. Park, L. Zhang and J.B. Rosen   "Low rank approximation of
%          a Hankel matrix by structured total least norm" 




% parameters 
% TODO: make them parameters of function so user can change them
tol = 10e-8;
if nargin<2
    maxiter = 1000;
end
w = 10e8;

% [u_D,u_N] = size(u);
% nc = R+1;
% nr = (u_N-nc+1)*u_D;

u = mex_unhankel_mo(Ab,1);

u_D = 1;
[nr, nc] = size(Ab);
u_N = nr+nc-1;
R = nc-1;

% make the input sequence hankel
% Ab = mex_hankel_mo(u,[nr nc]);

A = Ab(:,1:end-1);
b = Ab(:,end);


% initializations
if nargin>2
    x=x0;
else
    x = A\b;
end    
P1 = [zeros(nr,R*u_D) eye(nr,nr) ];
% P0 = [eye((u_N-1)*u_D) zeros((u_N-1)*u_D,u_D)];
eta = zeros(u_D*u_N,1);
D = eye(u_N*u_D);
%!!!
Yrow = zeros(1,u_D*(u_N-1));

delta = 1;

for iter=1:maxiter
    
    % form matrices 
    E   = mex_hankel_mo(reshape(eta,size(u)),[nr nc-1]);
%     E = hankel(eta(1:nr), eta(nr:u_N-1) );
%     Y = toeplitz( [x(1,1);zeros(nr-1,1)], [x; zeros(nr-1,1)] );
    Yrow(1:u_D:u_D*R) = x';
    Y = toeplitz([Yrow(1,1);zeros(nr-1,1)], Yrow );
    % Y*P0 = [Y|0]
    YP0 = [Y zeros(nr,u_D)];
    
    
    f   = eta(end-nr+1:end);
    
    % compute r
    r = b+f - (A+E)*x;
    
    % form M
     M = [ w*(P1-YP0) -w*(A+E);...
           D  zeros(u_N*u_D,R) ];
    
    % solve minimization problem 
    dparam = M\(-[w*r;D*eta]);
    
    % update parameters
    deta = dparam(1:u_N*u_D,1);
    dx   = dparam(u_N*u_D+1:end,1);
    
    
    
    eta = eta + delta *deta;
    x = x +delta *dx;
    
    if 1 
        delta = delta*0.99;
    end
    
    % check convergence
%     norm_func = norm([w*r;D*eta]);
    norm_dparam = norm(dparam);
    
%     fprintf('iteration:%d norm_dparam:%g norm_func:%g\n',iter,norm_dparam,norm_func);
    
    if 0
        figure(11)
        plot([u' (u+eta')']);
    end
    
    if norm_dparam <tol
        break;
    end    
end
eta = reshape(eta,size(u));
r = r';

Hr = Ab + [E f];



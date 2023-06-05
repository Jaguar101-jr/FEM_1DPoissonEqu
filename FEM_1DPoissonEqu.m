
%% A program to solve 1D Poisson Equ. via Finite-Element Methods
%% Equation: -d^2u/dx^2 = f(x);  0 < x < L
%% subject to the boundary conditions:
%% u(0) = 0, u(L) = 1


% grid parameters
L = 1; % Domain length
Nx = 10; % Number of elements
h = L/Nx; % Element size

 % Generate mesh and connectivity
x = linspace(0, L, Nx+1); % Node coordinates
elements = [(1:Nx)', (2:Nx+1)']; % Element connectivity

% Assemble the system matrix and load vector
A = sparse(Nx+1, Nx+1); % System matrix
F = zeros(Nx+1, 1); % Load vector
for i = 1:Nx
    % Local node indices for the current element
    nodes = elements(i, :);
    
    % Element matrix and vector
    Ke = 1/h * [1, -1; -1, 1];
    Fe = h/2 * [f(x(nodes(1))); f(x(nodes(2)))];
    
    % Assemble local matrices into global matrices
    A(nodes, nodes) = A(nodes, nodes) + Ke;
    F(nodes) = F(nodes) + Fe;
end

% Apply boundary conditions
A(1, :) = 0;
A(1, 1) = 1;
F(1) = 0;
F(end) = 1;

% Solve the system
u = A \ F;

% Plot the solution
plot(x, u, 'o-');
xlabel('x');
ylabel('u');
title('Finite Element Solution');

% Define the function f(x)
function y = f(x)
    y = 1; % Example: constant source term
end

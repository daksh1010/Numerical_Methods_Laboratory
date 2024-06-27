dx = 1/50;
dt = 0.01;
alpha = 1/(pi^2);
lambda = alpha * (dt/(dx^2));
rows = .1/dt + 1;
cols = 1/dx + 1;
U = zeros(rows, cols);

for i = 1:cols
    U(1, i) = sin(pi*(i-1)*dx);
end

a = 2*(1+lambda);
b = -lambda;
c = -lambda;

A = diag(a*ones(1,cols-2)) + diag(b*ones(1,cols-3),1) + diag(c*ones(1,cols-3),-1);

a = 2*(1-lambda);
b = lambda;
c = lambda;
B = diag(a*ones(1,cols-2)) + diag(b*ones(1,cols-3),1) + diag(c*ones(1,cols-3),-1);

for i = 2:rows
    x = inv(A)*B*U(i-1, 2:cols-1)';
    for j = 1:cols-2
        U(i, j+1) = x(j);
    end
end

dx = 1/50;
dt = 0.01;
alpha = 1/(pi^2);
lambda = alpha * (dt/(dx^2));
rows = .1/dt + 1;
cols = 1/dx + 1;
W = zeros(rows, cols);


for i = 1:cols
    W(1, i) = sin(pi*(i-1)*dx);
end

for i = 2:rows
    for j = 2:cols-1
        W(i, j) = W(i-1, j) - lambda*(W(i-1, j+1) -2*W(i-1, j) + W(i-1, j-1));
    end
end

s1 = surf(linspace(0, 1, 51), linspace(0, 0.1, 11), U);
s1.EdgeColor = "none";
s2 = surf(linspace(0, 1, cols), linspace(0, 0.1, 0.1/dt + 1), W);
s2.EdgeColor = "none";

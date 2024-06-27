dx = 1/50;
dt = 0.01;
alpha = 1;
lambda = alpha * (dt/(dx^2));
rows = .05/dt + 1;
cols = (1/dx) + 1;
U = zeros(rows, cols);

for i = 1:cols
    U(1, i) = sin(pi*(i-1)*dx)+sin(2*pi*(i-1)*dx);
end
U(1, 1) = 0;
U(1, cols) = 0;

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


x1 = linspace(0, 1, cols);
y1 = linspace(0, 0.05, rows);
z = surf(x1, y1, U);
z.EdgeColor = "none";

U(rows, :)

dx = 1/50;
lambda = 0.5;
alpha = 1;
dt = lambda*(dx^2)/alpha;
cols = 1/dx + 1;
rows = floor(0.1/dt) +1;

W = zeros(rows, cols);

for i = 1:cols
    W(1, i) = sin(pi*(i-1)*dx)+sin(2*pi*(i-1)*dx);
end

for i = 2:rows
    for j = 2:cols-1
        W(i, j) = W(i-1, j) + lambda*(W(i-1, j+1) -2*W(i-1, j) + W(i-1, j-1));
    end
end

W(rows, :)
x2 = linspace(0, 1, cols);
y2 = linspace(0, 0.05, rows);
s = surf(x2, y2, W);
s.EdgeColor = 'none';


dx = 1/50;
dt = 0.9*((dx)^2)*0.5;
U = zeros(501, 51);

for i = 1:51
    U(1, i) = sin(pi*(i-1)*dx);
end

for i = 2:501
    for j = 2:50
        U(i, j) = U(i-1, j) + (dt/(dx^2))*(U(i-1, j+1) -2*U(i-1, j) + U(i-1, j-1));
    end
end

U(301, :)
U(401, :)
U(501, :)

x = linspace(0, 1, 51);
y1 = U(301, :);
plot(x, y1)

hold on
y2 = U(401, :);
plot(x, y2)

hold on
y3 = U(501, :);
plot(x, y3)

legend("300 timesteps", "400 timesteps", "500 timesteps")
%plot(linspace(0, 1, 51), U(301, :), "red", linspace(0, 1, 51), U(401, :), "blue", linspace(0, 1, 51), U(501, :), "yellow")

dx = 1/50;
dt = 0.9*((dx)^2)*0.5;
U = zeros(501, 51);

for i = 1:51
    if (i-1)*dx <= 0.5
        U(1, i) = 2*(i-1)*dx;
    else
        U(1, i) = 2*(1-(i-1)*dx);
    end
end

for i = 2:501
    for j = 2:50
        U(i, j) = U(i-1, j) + (dt/(dx^2))*(U(i-1, j+1) -2*U(i-1, j) + U(i-1, j-1));
    end
end

U(51, :)
U(101, :)
U(201, :)

x = linspace(0, 1, 51);
y1 = U(51, :);
plot(x, y1)

hold on
y2 = U(101, :);
plot(x, y2)

hold on
y3 = U(201, :);
plot(x, y3)

legend("50 timesteps", "100 timesteps", "200 timesteps")

%plot(linspace(0, 1, 51), U(51, :), "red", linspace(0, 1, 51), U(101, :), "blue", linspace(0, 1, 51), U(201, :), "yellow")


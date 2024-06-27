H = zeros(100000, 2001);
U = zeros(100000, 2001);
r = zeros(1, 2001);

for i = 1:2001
    if (i-1) >= 1000
        H(1, i) = 1;
    else
        H(1, i) = 2;
    end
end

t = 0;
dx = 1/100;
e = 1;
index = 0;

for j = 1:100000
    r = zeros(1, 2001);
    for i = 1:2001
        r(1, i) = abs(U(j, i)) + sqrt(9.81*H(j, i));
    end
    sr = max(r);
    dt = (e*dx)/sr;
    t= t+dt;

    if t > 1
        index = j;
        break
    end

    for k = 2:2000    
        H(j+1, k) = 0.5*(H(j, k+1)+H(j, k-1)) - 0.5*e/sr * (H(j, k+1) * U(j, k+1) - H(j, k-1)*U(j, k-1));
    end

    H(j+1, 1) = H(j+1, 2);
    H(j+1, 2001) = H(j+1, 2000);
    
    for k = 2:2000
        U(j+1, k) = (0.5*(U(j, k+1)*H(j, k+1) + H(j, k-1)*U(j, k-1)) - 0.5*e/sr*(H(j, k+1) * (U(j, k+1)^2) + 0.5*(9.81)*H(j, k+1)^2 - H(j, k-1)*(U(j, k-1))^2 -0.5*9.81*H(j, k-1)^2))/H(j+1, k);
    end

    U(j+1, 1) = U(j+1, 2);
    U(j+1, 2001) = U(j+1, 2000);
end

x_data = linspace(-10, 10, 2001);
plot(x_data, H(index, :), 'red')
%plot(x_data, U(index, :), 'blue')

for k = 1:index
    plot(x_data, H(k, :), 'r')
    xlabel('x');
    ylabel('y');
    axis([-10 10 1 2])
    pause(0.01);
end


H = zeros(100000, 5001);
U = zeros(100000, 5001);
r = zeros(1, 5001);

for i = 1:5001
    H(1, i) = exp((-(((i-1)/1000)-2)^2)/0.1);
end

t = 0;
dx = 1/1000;
e = 1;
index = 0;

for j = 1:100000
    r = zeros(1, 5001);
    for i = 1:5001
        r(1, i) = abs(U(j, i)) + sqrt(9.81*H(j, i));
    end
    sr = max(r);
    dt = (e*dx)/sr;
    t= t+dt;

    if t > 1
        index = j;
        disp(t)
        break
    end

    for k = 2:5000    
        H(j+1, k) = 0.5*(H(j, k+1)+H(j, k-1)) - 0.5*e/sr * (H(j, k+1) * U(j, k+1) - H(j, k-1)*U(j, k-1));
    end

    H(j+1, 1) = H(j+1, 2);
    H(j+1, 5001) = H(j+1, 5000);
    
    for k = 2:5000
        U(j+1, k) = (0.5*(U(j, k+1)*H(j, k+1) + H(j, k-1)*U(j, k-1)) - 0.5*e/sr*(H(j, k+1) * (U(j, k+1)^2) + 0.5*(9.81)*H(j, k+1)^2 - H(j, k-1)*(U(j, k-1))^2 -0.5*9.81*H(j, k-1)^2))/H(j+1, k);
    end

    U(j+1, 1) = U(j+1, 2);
    U(j+1, 501) = U(j+1, 5000);
end
x_data = linspace(0, 5, 5001);
plot(x_data, H(index, :), 'red')
plot(x_data, U(index, :), 'blue')

for k = 1:index
    plot(x_data, U(k, :), 'r')
    xlabel('x');
    ylabel('y');
    pause(0.005);
end


x_data = [0, 0.2, 0.4, 0.6, 0.8, 1.0];
y_data = [2, 0.2^3+2, 0.4^3+2, 0.6^3+2, 0.8^3+2, 1.0^3+2];

[row_num, col_num] = size(x_data);

N = col_num - 2;

A = diag(4*ones(1,N)) + diag(1*ones(1,N-1),1) + diag(1*ones(1,N-1),-1) 
y_data


D = zeros(col_num-2, 1);
M_0 = 0;
M_n = 0;

for i = 2:col_num-1
    D(i-1, 1) = 6*(y_data(i-1) - 2*y_data(i) + y_data(i+1))/(0.2^2);
end

D(1,1) = D(1, 1) - M_0;
D(col_num-2, 1) = D(col_num-2, 1) - M_n;

D
z = (A\D)

M = zeros(col_num, 1);

for k = 2:col_num-1
    M(k, 1) = z(k-1, 1);
end     

M(1, 1) = M_0;
M(col_num, 1) = M_n;

M = M'

x = input("enter value of x")

for i = 1:col_num-1
    if x >= x_data(i) && x <= x_data(i+1)
        break
    end
end
i
p_x = M(1, i)*((x_data(1, i+1)-x)^3/0.2-0.2*(x_data(1, i+1)-x))/6 + y_data(1, i)*(x_data(1,i+1)-x)/0.2 +  M(1, i+1)*((-x_data(1, i)+x)^3/0.2-0.2*(-x_data(1, i)+x))/6 + y_data(1, i+1)*(-x_data(1,i)+x)/0.2
error = abs(p_x-(x^3+2))


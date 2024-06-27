
    f = @(x,y) [y(2); (1-y(2)^2)/y(1)]; 
    x0 = 0;  y0 = [1;2];

    y2 = 2;
    options = odeset('RelTol',1e-6,'AbsTol',1e-9); % Adjust tolerances as needed

    x = 2;                            
    [xs1,ys1] = ode15s(f,[x0,x],y0, options);
    fprintf('predcited y(x) = %g with assumed slope %g \n',ys1(end,1), y0(2))
    s_0 = ys1(end, 1);

    x0 = 0;  y0 = [1;-1];

    x = 2;                            
    [xs2,ys2] = ode15s(f,[x0,x],y0, options);
    fprintf('predicted y(x) = %g with assumed slope %g\n',ys2(end,1), y0(2))
    s_1 = ys2(end, 1);

    s_2 = 0;
    tolerance = 0.0001;
    for i = 1:1000
        s_2 = secant(s_0, s_1);
        s_0 = s_1;
        s_1 = s_2;
        if abs(phi(s_2)) < tolerance
            fprintf('final predicted y value = %g, and given y value = %g\n',y2+phi(s_2), y2)
            break;
        end
    end

    [x_data ,y_data] = ode15s(f,[0,2],[1;s_2], options);
    plot(x_data,y_data(:,1),'b')              % plot solution y(t)
    title('Solution y(t) of IVP')
    xlabel('t'); ylabel('y(t)'); grid on

%%
function s_i = secant(s_1, s_2)
    s_i = s_2 - (s_2 - s_1)*(phi(s_2))/(phi(s_2) - phi(s_1));
end

function p = phi(s_1)
    f = @(x,y) [y(2); (1-y(2)^2)/y(1)]; 
    options = odeset('RelTol',1e-6,'AbsTol',1e-9); % Adjust tolerances as needed

    [~,yp] = ode15s(f,[0,2],[1;s_1], options);
    p = yp(end, 1) - 2;
end
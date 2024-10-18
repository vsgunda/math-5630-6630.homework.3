% Author: Vishnu Gunda / vsg0005@auburn.edu
% Date: 2024-10-17
% Assignment Name: hw03

classdef hw03
    methods (Static)
        function y_eval = p1(data, eval)
            % Barycentric Lagrange interpolation method
            %
            % :param: data: a matrix of size n x 2, where n is the number of data points
            %         data(:,1) is the x values (nodes)
            %         data(:,2) is the y values (function values at the nodes)
            % :param: eval: a vector of x values to evaluate the interpolating polynomial
            % :return: y_eval: a vector, the evaluations of resulting interpolating polynomial at x values in eval
            
            % Number of data points
            n = size(data, 1);
            
            % x values (nodes)
            x_vals = data(:, 1);
            
            % y values (function values at the nodes)
            y_vals = data(:, 2);
            
            % Compute the barycentric weights w_j
            w = ones(n, 1);
            for j = 1:n
                for i = 1:n
                    if i ~= j
                        w(j) = w(j) / (x_vals(j) - x_vals(i));
                    end
                end
            end
            
            % Number of points to evaluate the interpolating polynomial at
            m = length(eval);
            
            % Initialize the result vector
            y_eval = zeros(m, 1);
            
            % Compute the Lagrange interpolation using the barycentric form
            for k = 1:m
                % For each evaluation point eval(k), compute the interpolation
                x = eval(k);
                numerator = 0;  % Numerator of the barycentric formula
                denominator = 0;  % Denominator of the barycentric formula
                for j = 1:n
                    if x ~= x_vals(j)
                        term = w(j) / (x - x_vals(j));
                        numerator = numerator + term * y_vals(j);
                        denominator = denominator + term;
                    else
                        % If x matches a node, just return the corresponding y value
                        numerator = y_vals(j);
                        denominator = 1;
                        break;
                    end
                end
                
                % Compute the final result at eval(k)
                y_eval(k) = numerator / denominator;
            end
        end

        function p2()
            % Use equally spaced nodes and Chebyshev nodes to compute the Lagrange polynomial interpolation of 
            % f(x) = 1/(1 + 25x^2) and g(x) = sin(pi * x) on [-1, 1]. 
            % This code uses your implementation of p1 to compute the
            % interpolation, and record the maximum interpolation error at 1000 equally spaced points in [-1, 1].
            % ----------------------------------------------------------------------------------

            % First, run this function and tabulate your result in the table below. 
            % Then, make a comment/explanation on the trend of the error for **equally spaced nodes** as n increases for each function.

            % Write your comments here.
            % 
            % Equally Spaced Nodes: 
            %   f(x) error gets significantly larger as
            % n increases. This happens a lot more at the borders due to
            % Runge's phenomenon
            %   g(x) actually had error getting smaller up until n = 20, but
            % after that it grew exponentially. The error increased by
            % about a factor of 10 after each increment of n
            %
            % Chebyshev nodes: 
            %   f(x) and g(x) both had errors that got smaller as n
            %   increased. This is because Chebyshev nodes are designed to
            %   minimize interpolation error
            %
            

            % |n  |                        Function       | Error with equally spaced nodes | Error with Chebyshev nodes  |
            % |---|---------------------------------------|---------------------------------|-----------------------------|
            % |  5|                @(x)1./(1+25*x.^2)     | 4.3267e-01                      |  5.5589e-01                 |
            % | 10|                @(x)1./(1+25*x.^2)     | 1.9156e+00                      |  1.0915e-01                 |
            % | 15|                @(x)1./(1+25*x.^2)     | 2.1069e+00                      |  8.3094e-02                 |
            % | 20|                @(x)1./(1+25*x.^2)     | 5.9768e+01                      |  1.5333e-02                 |
            % | 25|                @(x)1./(1+25*x.^2)     | 7.5764e+01                      |  1.1411e-02                 |
            % | 30|                @(x)1./(1+25*x.^2)     | 2.3847e+03                      |  2.0613e-03                 |
            % | 35|                @(x)1./(1+25*x.^2)     | 3.1708e+03                      |  1.5642e-03                 |
            % | 40|                @(x)1./(1+25*x.^2)     | 1.0438e+05                      |  2.8935e-04                 |
            % | 45|                @(x)1./(1+25*x.^2)     | 1.4243e+05                      |  2.1440e-04                 |
            % | 50|                @(x)1./(1+25*x.^2)     | 4.8161e+06                      |  3.9629e-05                 |
            % | 55|                @(x)1./(1+25*x.^2)     | 6.8288e+06                      |  2.9383e-05                 |
            % |---|---------------------------------------|---------------------------------|-----------------------------|
            % |  5|                     @(x)sin(pi*x)     | 2.6754e-02                      |  1.3193e-02                 |
            % | 10|                     @(x)sin(pi*x)     | 5.1645e-05                      |  6.0348e-06                 |
            % | 15|                     @(x)sin(pi*x)     | 9.2163e-10                      |  2.0995e-11                 |
            % | 20|                     @(x)sin(pi*x)     | 5.4114e-13                      |  9.9920e-16                 |
            % | 25|                     @(x)sin(pi*x)     | 1.2326e-11                      |  8.8818e-16                 |
            % | 30|                     @(x)sin(pi*x)     | 1.9045e-10                      |  9.9920e-16                 |
            % | 35|                     @(x)sin(pi*x)     | 4.4139e-09                      |  9.9920e-16                 |
            % | 40|                     @(x)sin(pi*x)     | 1.4273e-07                      |  9.9920e-16                 |
            % | 45|                     @(x)sin(pi*x)     | 7.3849e-06                      |  1.1102e-15                 |
            % | 50|                     @(x)sin(pi*x)     | 1.7894e-04                      |  1.1102e-15                 |
            % | 55|                     @(x)sin(pi*x)     | 5.1450e-03                      |  1.3323e-15                 |
            % |---|---------------------------------------|---------------------------------|-----------------------------|

            eval_pts = linspace(-1, 1, 1000)';
            funcs = { @(x) 1 ./ (1 + 25 * x.^2), @(x) sin(pi * x) };
            fprintf('|n  |                        Function       | Error with equally spaced nodes | Error with Chebyshev nodes  |\n');
            fprintf('|---|---------------------------------------|---------------------------------|-----------------------------|\n');
            
            for i = 1:2
                func = funcs{i};
                % Loop over degrees of polynomial from n = 5 to n = 55, increasing by 5
                for n = 5:5:55
                    % Equally spaced nodes
                    x_eq = linspace(-1, 1, n+1);
                    y_eq = func(x_eq);
                    y_eval_eq = hw03.p1([x_eq', y_eq'], eval_pts);  % Interpolate using your p1 function
                    eq_error_f = max(abs(func(eval_pts) - y_eval_eq));  % Calculate maximum error
        
                    % Chebyshev nodes
                    x_cheby = cos((2 * (1:(n+1)) - 1) * pi / (2 * (n+1)));  % Chebyshev nodes formula
                    y_cheby = func(x_cheby);
                    y_eval_cheby = hw03.p1([x_cheby', y_cheby'], eval_pts);  % Interpolate using your p1 function
                    cheby_error_f = max(abs(func(eval_pts) - y_eval_cheby));  % Calculate maximum error
        
                    % Print the results for each degree n
                    fprintf('| %2d|    %30s     | %6.4e                      |  %6.4e                 |\n', ...
                        n, functions(func).function, eq_error_f, cheby_error_f);
                end
                fprintf('|---|---------------------------------------|---------------------------------|-----------------------------|\n');
            end
        end

        function p3()
            % **Only for 6630**.
            % Use the extreme Chebyshev nodes to compute the Lagrange polynomial interpolation of 
            % f(x) = 1/(1 + 25x^2) and g(x) = sin(pi * x) on [-1, 1]. 
            % This code uses your implementation of p1 to compute the
            % interpolation, and record the maximum interpolation error at 1000 equally spaced points in [-1, 1].
            % ----------------------------------------------------------------------------------

            % Run this function and tabulate your result in the table below. 
            % Then, make a comment on the performance of the extreme Chebyshev nodes compared to Chebyshev nodes.

            % Write your comment here.
            %
            % The extreme Chebyshev nodes seemed to actually perform
            % similarly to the normal ones. They performed slightly worse, 
            % which is expected because of the endpoints being included,
            % but I thought it would be much worse. For accuracy the normal
            % Chebyshev nodes are better, but there may be some
            % applications where the extreme ones are required.
            %
            %
            %

            % |n  |                        Function       | Error with extreme Chebyshev nodes  |
            % |---|---------------------------------------|-------------------------------------|
            % |  5|                @(x)1./(1+25*x.^2)     | 6.3862e-01                          |
            % | 10|                @(x)1./(1+25*x.^2)     | 1.3219e-01                          |
            % | 15|                @(x)1./(1+25*x.^2)     | 9.9308e-02                          |
            % | 20|                @(x)1./(1+25*x.^2)     | 1.7738e-02                          |
            % | 25|                @(x)1./(1+25*x.^2)     | 1.3649e-02                          |
            % | 30|                @(x)1./(1+25*x.^2)     | 2.4252e-03                          |
            % | 35|                @(x)1./(1+25*x.^2)     | 1.8710e-03                          |
            % | 40|                @(x)1./(1+25*x.^2)     | 3.3987e-04                          |
            % | 45|                @(x)1./(1+25*x.^2)     | 2.5645e-04                          |
            % | 50|                @(x)1./(1+25*x.^2)     | 4.6187e-05                          |
            % | 55|                @(x)1./(1+25*x.^2)     | 3.5147e-05                          |
            % |---|---------------------------------------|-------------------------------------|
            % |  5|                     @(x)sin(pi*x)     | 1.3357e-02                          |
            % | 10|                     @(x)sin(pi*x)     | 1.1730e-05                          |
            % | 15|                     @(x)sin(pi*x)     | 2.1000e-11                          |
            % | 20|                     @(x)sin(pi*x)     | 1.5543e-15                          |
            % | 25|                     @(x)sin(pi*x)     | 7.7716e-16                          |
            % | 30|                     @(x)sin(pi*x)     | 9.9920e-16                          |
            % | 35|                     @(x)sin(pi*x)     | 7.7716e-16                          |
            % | 40|                     @(x)sin(pi*x)     | 1.3323e-15                          |
            % | 45|                     @(x)sin(pi*x)     | 1.3323e-15                          |
            % | 50|                     @(x)sin(pi*x)     | 1.2212e-15                          |
            % | 55|                     @(x)sin(pi*x)     | 1.4433e-15                          |
            % |---|---------------------------------------|-------------------------------------|

            eval_pts = linspace(-1, 1, 1000)';
            funcs = { @(x) 1 ./ (1 + 25 * x.^2), @(x) sin(pi * x) };
            fprintf('|n  |                        Function       | Error with extreme Chebyshev nodes  |\n');
            fprintf('|---|---------------------------------------|-------------------------------------|\n')
            for i = 1:2
                func = funcs{i};
                for n = 5:5:55
                    % extreme Chebyshev nodes
                    x = cos(((1:n+1) - 1) * pi / (n));
                    y = func(x);
                    y_eval = hw03.p1([x', y'], eval_pts);
                    ex_cheby_error_f = max(abs(func(eval_pts) - y_eval));
                    fprintf('| %2d|    %30s     | %6.4e                          |\n', n, functions(func).function, ex_cheby_error_f);
                end
                fprintf('|---|---------------------------------------|-------------------------------------|\n')
            end
        end
    end
end

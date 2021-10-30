close all
clear all
clc

size = 8;
lgsize = ceil(log2(size));

iterations = (2^size) * (2^size);

MulResultsOptimized = zeros(1, iterations);
Errors = zeros(1, iterations);

tic

t = 0;

it = 1;
for X = 0:2^size-1
    for Y = 0:2^size-1
        AccResult = X*Y;
        
        MulResultsOptimized(it) = fn_MitchellMul_Optimized(X, Y, 8);
        
        Errors(it) = (double(MulResultsOptimized(it)) - double(AccResult))/double(AccResult+eps)*100;
        
        it = it + 1;
    end
end
it = it - 1;

toc
AbsErrors = abs(Errors);

PeakErrors = max(AbsErrors, [], 2)
MaxErrors = max(Errors, [], 2);
MinErrors = min(Errors, [], 2);
MeanErrors = mean(AbsErrors, 2)
BiasErrors = mean(Errors, 2)
VarianeceErrors = var(Errors, 0, 2);
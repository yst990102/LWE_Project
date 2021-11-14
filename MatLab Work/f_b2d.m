function y=f_b2d(n)
S = strsplit(n, '.');
intV      = S{1} - '0';
fracV     = S{2} - '0';
intValue  = intV  * (2 .^ (numel(intV)-1:-1:0).');
fracValue = fracV * (2 .^ -(1:numel(fracV)).');
y = intValue + fracValue;
end
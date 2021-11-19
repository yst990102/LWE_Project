% approximate exp respecting bit arithmetic. X is an integer
function out = ecExp(x, deltas, k)
    len = size(deltas);
    n = log2(len(2)); % log of # subdivisions
    integ = floor(x);
    frac  = x-integ;
    msbs = floor(frac.*2.^n+1); % MSBS
    delta = trunc(reshape(deltas(msbs), size(x)), k-1); % Reshape to help with vectorization
    out = round(2.^integ.*(frac + delta + 1));
end
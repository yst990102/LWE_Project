% approximate log respecting bit arithmetic. X is an integer
function out = ecLog(x, deltas, k)  
    len = size(deltas);
    n = log2(len(2)); % log of # subdivisions
    
    integ = floor(log2(x)); % integer part. Obtainable using priority encoder.
    integ(x==0) = 1; % Set to zero to keep next line happy. x=0 is an invalid input anyway
    
    mant = trunc(x./(2.^integ) - 1, k-1);  % mantissa truncated to k-1 bits
    mant(x==0) = 0; % Also to keep the next line happy
    msbs = floor(mant.*2.^n + 1);
    delta = trunc(reshape(deltas(msbs), size(x)), k-1); % Reshape to help with vectorization
    
    % represented by log(N) bits for integer part, and + k-1 bits for the
    % fractional part.
    out = integ + mant + delta;
end
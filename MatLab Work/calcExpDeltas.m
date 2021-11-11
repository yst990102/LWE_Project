function deltas = calcExpDeltas(n, bitlen, errorMode)
    len = 2^n;
    step = 2^-bitlen;
    spacing = 2^(bitlen-n);
    
    deltas = zeros(1,len);
    
    % Select which error correction method to use
    switch (errorMode)
        case 'continuous'
            % Error Correction method 1: take integral average over interval
            correctionFunction = @continuousMean;
        case 'discrete'       
            % Error Correction method 2: take sum average over discrete points in the interval
            correctionFunction = @discreteMean;
        case 'precise'
            % Error correction method 3: Only consider the point. Use for
            % precise Logarithms.
            correctionFunction = @preciseDelta;
    end
    
    for i = 0:len-1
        deltas(i+1) = correctionFunction(@(x) 2.^x - aExp(x), i, spacing, step, len);
    end
end

function out = discreteMean(fn, i, spacing, step, len)
    out = sum(fn(step*(i*spacing+(0:spacing-1))))/spacing;
end

function out = continuousMean(fn, i, spacing, step, len)
    out = len*integral(@(x) fn(x), i/len,(i+1)/len);
end

function out = preciseDelta(fn, i, spacing, step, len)
    out = fn(i/len);
end

% approximate log (uncorrected)
function out = aLog(x)
    integ = floor(log2(x)); % integer part. Obtainable using barrel shift.
    mant = x./(2.^integ) - 1;  % mantissa
    out = integ + mant;
end

% approximate 2^x (uncorrected)
function out = aExp(x)
    integ = floor(x); % integer part
    frac  = x - integ; % fractional part  
    out   = 2.^integ.*(frac + 1);
end
% truncates and round the fractional part to a number of bits.
function out = trunc(x,bitlen)
    out = floor(x.*2.^bitlen).*2.^-bitlen;
    % check next bit after truncation point. If it is a 1, then round up.
    % add one unit to out to represent rounding.
    out = out + ((x-out).*2.^(bitlen+1) >= 1)*2.^-bitlen;    
end
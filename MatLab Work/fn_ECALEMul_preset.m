function [logdeltas, expdeltas,k] = fn_ECALEMul_preset(q)
% generate the logdeltas & expdeltas
bitlen = ceil(log2(q));

logME = 15; % log2 of # correction values for exponential. ME = 2^15
logML = bitlen-1; % log2 of # correction values for logarithmm. ML = 2^12
expdeltas = calcExpDeltas(logME, bitlen*2+1, 'discrete');
logdeltas = calcLogDeltas(logML, bitlen*2+1, 'precise');

k =  bitlen*2+1;
end


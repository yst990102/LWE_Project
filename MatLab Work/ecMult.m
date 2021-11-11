function out = ecMult(x,y,logdeltas, expdeltas, k)
    out = ecExp(ecLog(x,logdeltas,k) + ecLog(y,logdeltas,k),expdeltas,k);
    out(x==0) = 0; % Handle case where x or y is zero.
    out(y==0) = 0;   
end
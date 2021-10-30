function M = MatrixMul_UnsignedInt16_ApproxMuls (A,B)

[ra ca] = size(A);
[rb cb] = size(B);

sA = (A<0);
sB = (A<0);

A = uint32(abs(A));
B = uint32(abs(B));

M = int32(zeros(ra,cb));

for i = 1:ra
    for j = 1:cb
        vdp = int32(0);
        for k = 1:rb
            X = double(A(i,k));
            Y = double(B(k,j));
            
            mule = uint32(fn_MitchellMul_Optimized(X, Y, 8));
            sgne = xor(sA(i,k), sB(k,j));
            
            vdp = vdp  ((-1) ^ sgne) * int32(mule);
            
        end
        M(i,j) = vdp;
    end
end

end
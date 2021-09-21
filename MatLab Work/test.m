[q,A,e,s] = generator(0);

[A_row, A_col] = size(A);
for i = 1: A_row
    B(i,1) = A(i,:)*s;
end

B = mod(B + e, q);
uv_cells = EncryptMsgToUVs('0010',B,A,q);
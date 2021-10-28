function [Matrix_B] = B_normal_multiplier(A,s,e,q)
    Matrix_B = mod(A*s +e, q);
end


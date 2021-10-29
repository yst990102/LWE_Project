clc;
clear;
M = ones(1000, 1000);
for i = 1:1000
    for j = 1:1000
        M(i,j) = (i*j - fn_MitchellMul_REALM8x8_t(i,j,16,15));
    end
end
M = M / max(M(:));
M = abs(1 - M);
imshow(M,'Border','tight');
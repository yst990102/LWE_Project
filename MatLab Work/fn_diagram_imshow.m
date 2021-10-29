clc;
clear;
M = ones(1000, 1000);
for i = 1:1000
    for j = 1:1000
        M(i,j) = (i*j - fn_MitchellMul_MBM_t(i,j,16,15));
    end
end
M = M / max(M(:));
M = abs(1 - M);
imshow(M);
axis xy;
axis on;
xlabel('x');
ylabel('y');
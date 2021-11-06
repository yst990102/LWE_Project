clc;
clear;

fn_multiplier = input("Enter approximate-multi choice (1 - MBM, 2 - Optimized MBM, 3 - REALM8x8):", 's');
fn_multiplier_choice = str2double(fn_multiplier);

test_nums_input = input("Enter test cases:", 's');
test_nums = str2double(test_nums_input);

sz_str = input("Enter sz: ", 's');
sz = str2double(sz_str);

if ~fn_multiplier == 2
    k_str = input("Enter k: ", 's');
    k = str2double(k_str);
end

M = zeros(test_nums, test_nums);
for i = 1:test_nums
    for j = 1:test_nums
        % M(i,j) = (i*j - (fn_MitchellMul_MBM_t(i,j,16,16) - 0.08333*2^(GetFirstSignificantBit(dec2bin(i,8)) + GetFirstSignificantBit(dec2bin(i,8)))) );
        if fn_multiplier_choice == 1
            M(i,j) = (i*j - fn_MitchellMul_MBM_t(i,j,sz,k));
        elseif fn_multiplier_choice == 2
            M(i,j) = (i*j - fn_MitchellMul_Optimized(i,j,sz));
        else
            M(i,j) = (i*j - fn_MitchellMul_REALM8x8_t(i,j,sz,sz));
        end
        
    end
end
M = M / max(M(:));
M = abs(1 - M);
imshow(M);
axis xy;
axis on;
xlabel('x');
ylabel('y');
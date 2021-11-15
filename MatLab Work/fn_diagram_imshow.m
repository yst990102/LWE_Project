clc;
clear;

fn_multiplier = input("Enter approximate-multi choice (1 - MBM, 2 - Optimized MBM, 3 - REALM8x8, 4 - ECALE, 5 - LogMul):", 's');
fn_multiplier_choice = str2double(fn_multiplier);

test_nums_input = input("Enter test cases:", 's');
test_nums = str2double(test_nums_input);

if ismember(fn_multiplier_choice, [1 2 3])
    sz_str = input("Enter sz: ", 's');
    sz = str2double(sz_str);

    if ~fn_multiplier == 2
        k_str = input("Enter k: ", 's');
        k = str2double(k_str);
    end
elseif fn_multiplier_choice == 4
    fprintf("ECALE need to preset logdeltas & expdeltas, may need some time...");
    [logdeltas, expdeltas,k] = fn_ECALEMul_preset(8192);    % default config == 2
elseif fn_multiplier_choice == 5
    round_bits = input("Enter the fractional length of log:",'s');
    round_bits_num = str2double(round_bits);
    
    [LUT_int, LUT_fra] = GenerateLogLUT(test_nums, round_bits_num);     % for all config123 passed, at least 9
end


M = zeros(test_nums, test_nums);
for i = 1:test_nums
    for j = 1:test_nums
        if fn_multiplier_choice == 1
            M(i,j) = (i*j - fn_MitchellMul_MBM_t(i,j,sz,k));
        elseif fn_multiplier_choice == 2
            M(i,j) = (i*j - fn_MitchellMul_Optimized(i,j,sz));
        elseif fn_multiplier_choice == 3
            M(i,j) = (i*j - fn_MitchellMul_REALM8x8_t(i,j,sz,sz));
        elseif fn_multiplier_choice == 4
            M(i,j) = (i*j - ecMult(i,j,logdeltas,expdeltas,k));
        elseif fn_multiplier_choice == 5
            M(i,j) = (i*j - 2^( LUT_int(i) + LUT_fra(i) + LUT_int(j) + LUT_fra(j)));
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
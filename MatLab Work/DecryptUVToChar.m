function [M] = DecryptUVToChar(uv_cell,q,s)
    [~,bit_num] = size(uv_cell);
    M = zeros(1,bit_num);
    
    for i = 1:bit_num
        u = cell2mat(uv_cell{i}(1));
        v = cell2mat(uv_cell{i}(2));
        
        dec = mod(v - u*s, q);

        if round(3*q/4) < dec || dec < round(q/4)
            M(i) = 0;
        else
            M(i) = 1;
        end
    end
end


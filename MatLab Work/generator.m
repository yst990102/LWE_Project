function [q,A,e,s] = generator(configuration_num)

if configuration_num == 0
    % setting for A
    A_row = 8;
    A_col = 4;
    
    % setting for q
    q_min = 79;
    q_max = 79;
    
    % setting for e
    %e_min = -2;
    %e_max = 2;

elseif configuration_num == 1
    % setting for A
    A_row = 256;
    A_col = 4;
    
    % setting for q
    q_min = 1;
    q_max = 128;
    
    % setting for e
    %e_min = -1;
    %e_max = 1;

elseif configuration_num == 2
    % setting for A
    A_row = 8192;
    A_col = 8;
    
    % setting for q
    q_min = 2048;
    q_max = 8192;
    
    % setting for e
    %e_min = -4;
    %e_max = 4;

elseif configuration_num == 3
    % setting for A
    A_row = 32768;
    A_col = 16;
    
    % setting for q
    q_min = 16384;
    q_max = 65535;
    
    % setting for e
    %e_min = -16;
    %e_max = 16;

else
    error('configuration_num need to be [1,2,3]');
end 

% q_range
q_r = primes(q_max);
q_r = q_r(q_r >= q_min);
q = q_r(randperm(numel(q_r),1));

A = randi([0,q],A_row,A_col);
% e = randi([e_min,e_max],A_row,1);
%e = round(normrnd(0,0.341,A_row,1));
e = round(randn(A_row,1));
s = randi([0, q],A_col,1);

return

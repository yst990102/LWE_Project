function y=f_d2b(a)
n = 16;         % number bits for integer part of your number      
m = 20;         % number bits for fraction part of your number
% binary number
d2b = [ fix(rem(fix(a)*pow2(-(n-1):0),2)), fix(rem( rem(a,1)*pow2(1:m),2))];
% int part
int_part = d2b(1:n);
% fraction part
fra_part = d2b(n+1:end);

% convert to string
int_str = strjoin(string(int_part), "");
fra_str = strjoin(string(fra_part), "");

int_str = dec2bin(bin2dec(int_str));

y = strjoin([int_str, fra_str], ".");

end
  
clear;
clc;

B = zeros(10000,10000);

for row = 1:10000
    for col = 1:10000
        B(row, col) = row * col - 2^(log2(row) + log2(col));
    end
end
B = B / max(B(:));
B = abs(1 - B);
imshow(B);
axis xy;
axis on;
xlabel('x');
ylabel('y');
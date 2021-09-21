function x=gauss2(A,b)
%参量说明：A,系数矩阵；B，常数列向量；zg，增广矩阵
%将增广矩阵化为上三角，再回带求解x
%该方法为：zg(k,k)右下角的n-1阶方阵为第k列除zg(k,k)元素外的列向量除以zg(k,k)
%乘以第K行除了zg(k,k)元素外的行向量的值
n=length(b);
zg=[A,b];
for k=1:(n-1)
    zg((k+1):n,(k+1):(n+1))= zg((k+1):n,(k+1):(n+1))-zg((k+1):n,k)/zg(k,k)*zg(k,(k+1):(n+1));
    zg((k+1):n,k)=zeros(n-k,1);
end
 
x=zeros(n,1);
x(n)=zg(n,n+1)/zg(n,n);
for k=n-1:-1:1
    x(k,:)=(zg(k,n+1)-zg(k,(k+1):n)*x((k+1):n))/zg(k,k);
end
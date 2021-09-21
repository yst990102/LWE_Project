function x=gauss1(A,b)
%参量说明：A,系数矩阵；B，常数列向量；zg，增广矩阵
%将增广矩阵化为上三角，再回带求解x
%此方法较为常规，将zg(k,k)元素乘以-zg(i,k)/zg(k,k)加到第i行
%从1:n-1列，主对角元素的以下行，通过两层循环来遍历
zg=[A,b];
zj=rref(zg);
n=length(b);
ra=rank(A);
rz=rank(zg);
temp=rz-ra;
if temp>0
    disp('无解');
    return;
end
if ra==rz
    if ra==n
        x=zeros(n,1);
        for p=1:n-1
            for k=p+1:n
                m=zg(k,p)/zg(p,p);
                zg(k,p:n+1)=zg(k,p:n+1)-m*zg(p,p:n+1);
            end
        end
        b=zg(1:n,n+1);
        A=zg(1:n,1:n);
        x(n)=b(n)/A(n,n);
        for q=n-1:-1:1
            x(q)=(b(q)-sum(A(q,q+1:n)*x(q+1:n)))/A(q,q);
        end
    end
end
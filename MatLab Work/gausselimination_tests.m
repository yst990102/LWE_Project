clc;
%test1
A=[2,4,-6;1,5,3;1,3,2];
b=[-4;10;5];
x=gauss1(A,b)
x=gauss2(A,b)
%test2
A=[2,3,4;3,5,2;4,3,30];
b=[6,5,32]';
x=gauss1(A,b)
x=gauss2(A,b)
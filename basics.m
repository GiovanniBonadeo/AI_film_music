%matrices and vectores
clc, clear;

x = 1:10;
x = linspace(0,50, 51);
y = [1 2 3];
A = [1 3; 2 4];
A * A';
x.^2; %each element of array
A.^2;
A = ones(3, 1);
B = zeros(2,8);
C = eye(3);
x = 1:2:10;

A = [1 3; 9.1 5];
A(2,2); %index matrix position
A(end); %get end element

A(1,1) = 6;

A(2,:);



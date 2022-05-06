function [circle_in_x,circle_in_y]=evaluate_eva(I)
%用平均灰度的最值粗略估计瞳孔中心
[rows,cols]=size(I);
m=round(rows*0.3);
n=round(cols*0.3);
I(:,1:n)=200;
I(1:m,:)=200;
I(:,cols-n:cols)=200;
I(rows-m:rows,:)=200;

%I= medfilt2(I,[25 25],'symmetric');
% imshow(I)
%粗略估计瞳孔中心位置
num_x=sum(I);num_y = sum((I'));
% figure,
% subplot(121);plot(num_x);
% subplot(122);plot(num_y);
circle_x=find(num_x==min(num_x));
circle_y=find(num_y==min(num_y));
circle_in_x=circle_x(1);
circle_in_y=circle_y(1);
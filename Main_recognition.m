clc;clear;
%%
clc;clear;
I0=imread('test91.jpg');
[~,~,z]=size(I0);
P=I0;
if z>1
    P= rgb2gray(I0);
end
%对图像进行平滑处理 并缩小图像以加快速度
scaling=0.7;%0.7
P0=imresize(P,scaling);
I=blur_guass(P0,1.5);
I=medfilt2(I,[5 5],'symmetric');
I=light_del(I);%去除光源点
[m,n]=size(I);
%imshow(I)
% 对图像梯度化并做相关处理 
[circle_in_x,circle_in_y]=evaluate_eva(I);%粗略估计瞳孔中心位置

[J0,or]=Grad_my(I);
%imshow(J0)
J1=adjgamma(J0,2); %调整图像伽马值
J2=nonmaxsup(J1,or,1.5);%非极大抑制
J3=hysthresh(J2,0.002,0.0003);%双阈值1,2:(0.0025,0.0002)(0.005,0.004)
%J3=Grad_light(P0,J2); %去除光源点23=J3;

imshow(J3)

%%
% 先检测内边缘
J=J3;
%限定范围
col0=circle_in_x;row0=circle_in_y;r0=90*scaling;
for i=1:m
    for j=1:n
        if ((i-row0)^2+(j-col0)^2)>=r0^2
            J(i,j)=0;
        end
    end
end
mean_circle1=hough_circle2(J,1,0.0524,30*scaling,60*scaling);

% 再检测外边缘
J4=imresize(J3,1/scaling);
%缩小计算范围 
row0=mean_circle1(1);col0=mean_circle1(2);r0=mean_circle1(3);
for i=1:m
    for j=1:n
        if (((i-row0)^2+(j-col0)^2)>=(140*scaling)^2)||abs(row0-i) ...
            >=r0||(((i-row0)^2+(j-col0)^2)<=(70*scaling)^2)
            J3(i,j)=0;
        end
    end
end
mean_circle2=round(hough_circle(J3,1,0.0524,100*scaling,140*scaling)./scaling);
mean_circle1=round(mean_circle1./scaling);

% 作图
figure,
imshow(I0);
plot_circle(mean_circle1);
plot_circle(mean_circle2);

%%
%归一化处理
I_pole=circle2rectangle2(P,mean_circle1,mean_circle2,100,800);
%imshow(I_pole);
%%
noisewithmask=mask(P,J4,mean_circle1,mean_circle2);
imshow(noisewithmask)
%%
noisewithmask_pole=circle2rectangle2(noisewithmask,mean_circle1,mean_circle2,100,800);
%imshow(noisewithmask_pole)

mask_pole=mask_pole(noisewithmask_pole);

encode=main_encode(I_pole);
%imshow(encode)
%%

p=9;q=5;
M=zeros(p,q);
for i=1:p
    for j=1:q
    mask=imread(['mask_',num2str(i,'%d'), ...
        'L0',num2str(j,'%d'),'.jpg']);
    template=imread(['encode_',num2str(i,'%d'), ...
        'L0',num2str(j,'%d'),'.jpg']);
    M(i,j)=hamming_dis(template,encode,mask,mask_pole);
    end
end

a=(sum(M,2)/5)';
x=find(a==min(a));
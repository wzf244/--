function plot_circle(circle_num)
%����:
%Բ����   circle_num:
%                   circle_num(1) : Բ�ĺ�����
%                   circle_num(2) ��Բ��������
%                   circle_num(3) ��Բ�İ뾶
radius_y = double(circle_num(1));
radius_x =double(circle_num(2));
radius = double(circle_num(3));

alpha=0:pi/20:2*pi;%�Ƕ�[0,2*pi]
R=radius;           %�뾶
%������ͼ�Ķ�Ӧλ��
x=R*cos(alpha)+radius_x;   
y=R*sin(alpha)+radius_y;
hold on,plot(x,y, 'LineWidth',2 )
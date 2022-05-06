function plot_circle(circle_num)
%输入:
%圆参数   circle_num:
%                   circle_num(1) : 圆心横坐标
%                   circle_num(2) ：圆心纵坐标
%                   circle_num(3) ：圆的半径
radius_y = double(circle_num(1));
radius_x =double(circle_num(2));
radius = double(circle_num(3));

alpha=0:pi/20:2*pi;%角度[0,2*pi]
R=radius;           %半径
%规整到图的对应位置
x=R*cos(alpha)+radius_x;   
y=R*sin(alpha)+radius_y;
hold on,plot(x,y, 'LineWidth',2 )
function [y,or]=Grad_my(im)
im=double(im);
[rows,cols]=size(im);
h=([im(:,2:cols) zeros(rows,1)]-[zeros(rows,1) im(:,1:cols-1)])/2;
v=([im(2:rows,:);zeros(1,cols)]-[zeros(1,cols);im(1:rows-1,:)])/2;
d1=([im(2:rows,2:cols) zeros(rows-1,1);zeros(1,cols)]- ...
   [zeros(1,cols);zeros(rows-1,1) im(1:rows-1,1:cols-1)])/2*sqrt(2);
d2=([zeros(1,cols); im(1:rows-1,2:cols) zeros(rows-1,1);]- ...
   [zeros(rows-1,1) im(2:rows,1:cols-1);zeros(1,cols)])/2*sqrt(2);
X=h+d1+d2;
Y=v+d1-d2;
y=sqrt((X.*X+Y.*Y)/2);
y=y-min(min(y));
y=y./max(max(y));

or = atan2(Y, X);            % 角度 -pi 到 + pi.
neg = or<0;                   % 转化到  0-pi.
or = or.*~neg + (or+pi).*neg; 
or = or*180/pi; 
end
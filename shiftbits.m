function im_new = shiftbits(im,noshifts)
% shiftbits - 用于转换虹膜模板位数，以至于找到最好的匹配
%
% 说明: 
%   im_new=shiftbits(im,noshifts)
%
% 自变量:
%	im              - 要转换的图像
%   noshifts        - 向右转换的次数, 负数代表向左(一次转换2个像素点)
%
% 输出:
%   im_new          - 转换后的图像

im_new=zeros(size(im));

cols=size(im,2);
s=2*abs(noshifts);
p=cols-s;

if p<1
    error('the value of noshifts is too much');
end

if noshifts==0
    im_new=im;
    
elseif noshifts < 0
    x=1:p;
    im_new(:,x)=im(:,s+x);
    x=(p+1):cols;
    im_new(:,x) = im(:,x-p);
else
    x=(s+1):cols;
    im_new(:,x)=im(:,x-s);
    x=1:s;
    im_new(:,x)=im(:,p+x);
end
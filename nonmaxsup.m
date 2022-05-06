function im=nonmaxsup(inimage,orient,radius)
%
%
% 说明:         
%       im=nonmaxsup(inimage,orient,radius);
%
% 实行非极大抑制的函数。
% 假定方向图给出了特征正常方向角(0-180).
%
% 输入:
%   inimage - 原始图像
% 
%   orient  - 包含特征正常方向角的图像(0-180), 角度正是逆时针
%             
%   
%   radius  - 在确定是否为局部最大值时，在每个像素点
%             的每一边寻找的像素单位的距离(通常为 1.2 - 1.5)
% 输出：
%   im      - 处理后的图像
% 注意: 这个函数特别慢.  它使用双线性差值估计的强度值。



if size(inimage) ~= size(orient)
  error('image and orientation image are of different sizes');
end

if radius<1
  error('radius must be >= 1');
end

[rows,cols]=size(inimage);
im=zeros(rows,cols);
iradius=ceil(radius);%向上取整

%对每个方向的角度预先计算与中心像素点的x和y偏移量

angle=(0:180).*pi/180; % 步长为1度的角度阵列 (弧度).
xoff=radius*cos(angle);% 每个相关位置的特定半径和角度点的x和y偏移量
yoff=radius*sin(angle);   

xfrac=xoff-floor(xoff); % xoff相对于整数位置的分数偏移量
yfrac=yoff-floor(yoff); % yoff相对于整数位置的分数偏移量

orient=fix(orient)+1; %方向从零开始但是数组从索引1开始

%现在对被用于非极大抑制的中心像素点的每一侧进行灰度值图像插值

for row=(iradius+1):(rows-iradius)
  for col=(iradius+1):(cols-iradius) 

    or=orient(row,col);  

    x=col+xoff(or);     % x, y位于讨论的点的一侧
    y=row-yoff(or);

    fx=floor(x); % 获得围绕x,y的整数像素点的位置
    cx=ceil(x);
    fy=floor(y);
    cy=ceil(y);
    tl=inimage(fy,fx);    % 左上方的值
    tr=inimage(fy,cx);    % 右上
    bl=inimage(cy,fx);    % 左下
    br=inimage(cy,cx);    % 右下

    upperavg=tl+xfrac(or)*(tr-tl);% 用双线性插值估计x,y处的值
    loweravg=bl+xfrac(or)*(br-bl); 
    v1=upperavg+yfrac(or)*(loweravg-upperavg);

  if inimage(row,col)>v1 %如果那一侧不是最大的

    x=col-xoff(or);     % 则比较另一侧的x, y
    y=row+yoff(or);

    fx = floor(x);
    cx = ceil(x);
    fy = floor(y);
    cy = ceil(y);
    tl = inimage(fy,fx);  
    tr = inimage(fy,cx);   
    bl = inimage(cy,fx);   
    br = inimage(cy,cx);    
    upperavg=tl+xfrac(or)*(tr - tl);
    loweravg=bl+xfrac(or)*(br - bl);
    v2=upperavg+yfrac(or)*(loweravg-upperavg);

    if inimage(row,col)>v2            % 是局部最大(梯度方向)
      im(row,col)=inimage(row,col); 
    end

   end
  end
end



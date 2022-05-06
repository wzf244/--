function bw=hysthresh(im, T1, T2)
%   用双阈值进行二值化
% 说明:  bw=hysthresh(im, T1, T2)
%
%参数:
%             im  - 原图
%             T1  - 高阈值
%             T2  - 低阈值
%
% 输出:
%             bw  - 处理后的图像(0,1图)



if (T2 > T1 || T2 < 0 || T1 < 0)  % 阈值要合理
  error('T1 must be >= T2 and both must be >= 0 ');
end

[rows,cols]=size(im);
rc=rows*cols;
rcmr=rc-rows;
rp1=rows+1;

bw=im(:);                 % 将图像转化为向量
pix=find(bw>T1);        
npix=size(pix,1);       

stack=zeros(rows*cols,1); % 创建一个栈,不会溢出

stack(1:npix)=pix;        % 把所有边缘点放进栈中
stp=npix;                 % 设置栈的指针
for k=1:npix
    bw(pix(k))=-1;        % 标记边界
end

% 图像被转换成了一个列向量，所以个方向的索引为:
%              n-rows-1   n-1   n+rows-1
%
%               n-rows     n     n+rows
%                     
%              n-rows+1   n+1   n+rows+1

Q = [-1, 1, -rows-1, -rows, -rows+1, rows-1, rows, rows+1];

while stp ~= 0            % 栈非空
    v=stack(stp);         % 将一个像素点移出栈
    stp=stp-1;
    
    if v>rp1 && v<rcmr  
			    %检测的像素点是否应该加入栈中
       index=Q+v;	    % 计算周围点的索引
       for i=1:8
	   ind=index(i);
	   if bw(ind)>T2   % 如果大于低阈值，则将它的索引放入栈中
	       stp=stp+1;  
	       stack(stp)=ind;
	       bw(ind)=-1; % 标记边界值
	   end
       end
    end
end

bw=(bw==-1);            % 最后删除所有非边界点
bw=reshape(bw,rows,cols); % 还原图像

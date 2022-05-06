function J=regiongrowing(I,y,x,Threshold)
%
%     函数功能：是找到一片与种子点灰度相近的一片区域
%
%------------------------------输入参数-----------------------------
%       I：灰度图像
%       阀值选择范围 Threshold ：（附近点的灰度与种子点的差值）
%             区分内轮廓时：  20~30  ，30较好
%       种子点位置 (x,y)
%------------------------------输出参数-----------------------------
%  Note： 函数返回： J最终为轮廓的边缘图像，为hough变换寻找内圆做准备                 
%-------------------------------------------------------------------
I = double(I);      %转换类型
J = zeros(size(I)); % 定义一个输出 
Isizes = size(I);   %图像大小
reg_mean = I(x,y); % 种子点灰度值
reg_size = 1;      % 分割区域内点的个数（初始值就为种子点一个）
%开辟一个区域存放满足区域条件的点
neg_free = 10000; neg_pos=0;
neg_list = zeros(neg_free,3); 
pixdist=0; %检测点与阈值的差值

%种子点附近--四连通区域的点
neigb=[-1 0; 1 0; 0 -1;0 1];  %相对种子点的x与y的增量
number = Isizes(1)*Isizes(2);    %循环的最大次数
%  
%循环开始，结束条件：当整个可用种子列表中最小的灰度值都小于阈值
%                   或者所有点都检测完了
while pixdist<Threshold&&number>0 
number = number - 1;
% num = num + 1;
    % Add new neighbors pixels
    for j=1:4
        %计算种子点附近的四连通区域点
        xn = x +neigb(j,1); yn = y +neigb(j,2);
        % 检测是否在图像范围内
        ins=(xn>=1)&&(yn>=1)&&(xn<=Isizes(1))&&(yn<=Isizes(2));
        
        % Add neighbor if inside and not already part of the segmented area
        if ins&&(J(xn,yn)==0)    %在范围之内并且该点没有被检测到
             neg_pos = neg_pos+1;  
             neg_list(neg_pos,:) = [xn yn I(xn,yn)]; %记录该点位置以及灰度值
             J(xn,yn)=1;  %并且标记该点
        end
    end
    %-------继续扩充列表内存  
      if neg_pos+4>neg_free
         neg_free=neg_free+1000;
         neg_list((neg_pos+1):neg_free,:)=0; 
      end
 
    %找到整个可用候选种子列表中灰度最近的那个点作为新的检测种子点
    dist = abs(neg_list(1:neg_pos,3)-reg_mean);
    %选择候选种子点中灰度差异性最小的那个点作为下一个要进行检测扩展的种子点
    [pixdist, index] = min(dist);    %最小值是pixdist  在列向量的第index个
    %满足要求的点记录下来
    J(x,y)=2; reg_size=reg_size+1;
    %已经找到的区域内的点的平均灰度值
    %这个时候不再是以原始的种子点灰度值作为检测值，加大准确性
    reg_mean = (reg_mean*reg_size + neg_list(index,3))/(reg_size+1);  
    x = neg_list(index,1); y = neg_list(index,2); %下一个检测的新种子坐标
    %将这个要检测的点从候选种子列表中剔除掉
    %并非真的剔除了，只是指向了下一次形成的新的种子点位置，看起来就是剔除了
    neg_list(index,:)=neg_list(neg_pos,:); neg_pos=neg_pos-1;
end
%找到区域内的点
J=(J>1);
%将二值图进一部转化为边缘检测的图像
edg = edge(J,'canny');
J=edg;
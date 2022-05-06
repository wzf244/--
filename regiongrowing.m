function J=regiongrowing(I,y,x,Threshold)
%
%     �������ܣ����ҵ�һƬ�����ӵ�Ҷ������һƬ����
%
%------------------------------�������-----------------------------
%       I���Ҷ�ͼ��
%       ��ֵѡ��Χ Threshold ����������ĻҶ������ӵ�Ĳ�ֵ��
%             ����������ʱ��  20~30  ��30�Ϻ�
%       ���ӵ�λ�� (x,y)
%------------------------------�������-----------------------------
%  Note�� �������أ� J����Ϊ�����ı�Եͼ��Ϊhough�任Ѱ����Բ��׼��                 
%-------------------------------------------------------------------
I = double(I);      %ת������
J = zeros(size(I)); % ����һ����� 
Isizes = size(I);   %ͼ���С
reg_mean = I(x,y); % ���ӵ�Ҷ�ֵ
reg_size = 1;      % �ָ������ڵ�ĸ�������ʼֵ��Ϊ���ӵ�һ����
%����һ���������������������ĵ�
neg_free = 10000; neg_pos=0;
neg_list = zeros(neg_free,3); 
pixdist=0; %��������ֵ�Ĳ�ֵ

%���ӵ㸽��--����ͨ����ĵ�
neigb=[-1 0; 1 0; 0 -1;0 1];  %������ӵ��x��y������
number = Isizes(1)*Isizes(2);    %ѭ����������
%  
%ѭ����ʼ���������������������������б�����С�ĻҶ�ֵ��С����ֵ
%                   �������е㶼�������
while pixdist<Threshold&&number>0 
number = number - 1;
% num = num + 1;
    % Add new neighbors pixels
    for j=1:4
        %�������ӵ㸽��������ͨ�����
        xn = x +neigb(j,1); yn = y +neigb(j,2);
        % ����Ƿ���ͼ��Χ��
        ins=(xn>=1)&&(yn>=1)&&(xn<=Isizes(1))&&(yn<=Isizes(2));
        
        % Add neighbor if inside and not already part of the segmented area
        if ins&&(J(xn,yn)==0)    %�ڷ�Χ֮�ڲ��Ҹõ�û�б���⵽
             neg_pos = neg_pos+1;  
             neg_list(neg_pos,:) = [xn yn I(xn,yn)]; %��¼�õ�λ���Լ��Ҷ�ֵ
             J(xn,yn)=1;  %���ұ�Ǹõ�
        end
    end
    %-------���������б��ڴ�  
      if neg_pos+4>neg_free
         neg_free=neg_free+1000;
         neg_list((neg_pos+1):neg_free,:)=0; 
      end
 
    %�ҵ��������ú�ѡ�����б��лҶ�������Ǹ�����Ϊ�µļ�����ӵ�
    dist = abs(neg_list(1:neg_pos,3)-reg_mean);
    %ѡ���ѡ���ӵ��лҶȲ�������С���Ǹ�����Ϊ��һ��Ҫ���м����չ�����ӵ�
    [pixdist, index] = min(dist);    %��Сֵ��pixdist  ���������ĵ�index��
    %����Ҫ��ĵ��¼����
    J(x,y)=2; reg_size=reg_size+1;
    %�Ѿ��ҵ��������ڵĵ��ƽ���Ҷ�ֵ
    %���ʱ��������ԭʼ�����ӵ�Ҷ�ֵ��Ϊ���ֵ���Ӵ�׼ȷ��
    reg_mean = (reg_mean*reg_size + neg_list(index,3))/(reg_size+1);  
    x = neg_list(index,1); y = neg_list(index,2); %��һ����������������
    %�����Ҫ���ĵ�Ӻ�ѡ�����б����޳���
    %��������޳��ˣ�ֻ��ָ������һ���γɵ��µ����ӵ�λ�ã������������޳���
    neg_list(index,:)=neg_list(neg_pos,:); neg_pos=neg_pos-1;
end
%�ҵ������ڵĵ�
J=(J>1);
%����ֵͼ��һ��ת��Ϊ��Ե����ͼ��
edg = edge(J,'canny');
J=edg;
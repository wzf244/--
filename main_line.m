clc;clear;
BW0=imread('L02.jpg');
BW=imread('Bin2.jpg');
% 
% line=findline2(BW,pi/2,pi);
% [x,y]=linecoords(line,BW0,pi/2,pi);
% imshow(BW0)
% hold on
% [n,~]=size(x);
% for i=1:n
%     plot(x(i,:),y(i,:),'Color','r','LineWidth',2)
% end

noisewithmask=mask(BW0,BW);
%imwrite(noisewithmask,'noisewithmask.jpg')

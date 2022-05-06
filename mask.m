function noisewithmask=mask(BW0,BW,mean_circle1,mean_circle2)
%mean_circle1=[117;154;56];
%mean_circle2=[115;156;110];
[m,~]=size(BW);
noisewithmask=BW0;
%noisewithmask=ones(size(BW0));
t1=pi/4;t2=pi*0.465;
t3=pi/2;t4=3/4*pi;
%区域4
[x,y]=findline3(BW,t1,t2,mean_circle1,mean_circle2, ...
    250,500);
%1,2:(t1,t2,120,300)4:(t2,t4,200,250)3,5,6,7,8,9:(t1,t2,250,500)
%[x,y]=linecoords(line,BW0,t1,t2);
n=length(x);
for j=1:n
    for i=y(j):m
        noisewithmask(i,j)=0;
    end
end
%区域3
[x,y]=findline3(BW,t3,t4,mean_circle1,mean_circle2, ...
    150,250);%1,2:(t3,t4,150,400) 4:(t3,t4,120,180)3,5,6,7,8,9:(t3,t4,150,250)
%[x,y]=linecoords(line,BW,t3,t4);
n=length(x);
for j=1:n
    for i=y(j):m
        noisewithmask(i,j)=0;
    end
end

%区域1
[x,y]=findline3(BW,t1,t2,mean_circle1,mean_circle2, ...
    100,200);%1,2:(t1,t2,0,60)4:(t1,t2,0,130)3,5,6,7,8,9:(t1,t2,100,200)
%[x,y]=linecoords(line,BW0,t1,t2);
n=length(x);
for j=1:n
    for i=1:y(j)
        noisewithmask(i,j)=0;
    end
end
%区域2
[x,y]=findline3(BW,t3,t4,mean_circle1,mean_circle2, ...
    0,100);%1:(t3,t4,0,60)2:(t2,pi-t2,0,60) 
%               4:(t3,t4,0,60)3,5,6,7,8,9:(t3,t4,0,100)
%[x,y]=linecoords(line,BW0,t3,t4);
n=length(x);
for j=1:n
    for i=1:y(j)
        noisewithmask(i,j)=0;
    end
end
%imshow(noisewithmask);
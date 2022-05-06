function result=main_encode(I)
[rows,cols]=size(I);
result=zeros(8*rows,cols);
i=0;
for theta=[0,pi/4,pi/2,pi*3/4]
    %z=gb_new(5,5,0.2,0,theta);
    z=gb_new(2,2,0.1,0,theta);%z=gb_new(4,8,0.25,0,theta);(2,4,0.15/0.1,0,theta)
    filtered=imfilter(I,z,'corr','same');
    result0=encode1(filtered);
    result(2*i*rows+1:2*(i+1)*rows,:)=result0;
    i=i+1;
end

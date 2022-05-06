function mask_pole=mask_pole(noisewithmask_pole)
[m,n]=size(noisewithmask_pole);
mask_pole=zeros(8*m,n);
for i=1:8
    mask_pole((i-1)*m+1:i*m,:)=noisewithmask_pole;
end

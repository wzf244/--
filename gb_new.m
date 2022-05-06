function gabor_k=gb_new(r,g,u0,v0,theta)
nsize=15;
gabor_k=ones(nsize);
x=0;
for X=linspace(-10,10,nsize)
    x=x+1;
    y=0;
    for Y=linspace(-10,10,nsize)
        x1=X*cos(theta)+Y*sin(theta);
        y1=-X*sin(theta)+Y*cos(theta);
        gabor_k(x,nsize-y)=exp(-(x1^2/(2*r^2)+y1^2/(2*g^2))) ...
            *exp(1i*2*pi*(u0*x1+v0*y1)); 
        y=y+1;
    end
end

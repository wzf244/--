clc;clear;
p=9;q=5;
for s=1:p
    for t=1:q
        I_pole=imread(['pole_',num2str(s,'%d'),'L0', ...
            num2str(t,'%d'),'.jpg']);
        encode=main_encode(I_pole);
        imwrite(encode,['encode_',num2str(s,'%d'),'L0', ...
            num2str(t,'%d'),'.jpg']);
    end
end
%% čŻťĺĺžĺĺšśç°ĺşŚĺ
clear;clc;
I0 = imread('L02.jpg');
[~, ~, z] = size(I0);
P = I0;

if z > 1
    P = rgb2gray(I0);
end

%% ĺŻšĺžĺčżčĄĺšłćťĺ?ç ĺšśçźŠĺ°ĺžĺäťĽĺ ĺżŤéĺşŚ
scaling = 1; %0.7
P0 = imresize(P, scaling);
I = blur_guass(P0, 2);
I = medfilt2(I, [5 5], 'symmetric');
I = light_del(I); %ĺťé¤ĺćşç?
%imshow(I)

[m, n] = size(I);
%imshow(I)
%% ĺŻšĺžĺć??ĺşŚĺĺšśĺç¸ĺłĺ¤ç
[circle_in_x, circle_in_y] = evaluate_eva(I); %ç˛çĽäź°č?Ąçłĺ­ä¸­ĺżä˝ç˝?

[J0, or] = Grad_my(I)
%imshow(J0)
J1 = adjgamma(J0, 2); %č°ć´ĺžĺäź˝éŠŹĺ?
J2 = nonmaxsup(J1, or, 1.5); %éćĺ¤§ćĺ?
J3 = hysthresh(J2, 0.001, 0.00007);%ĺéĺ?(0.001,0.00007)
%J4=hysthresh(J2,0.002,0.002); %ĺéĺ?
imshow(J3)
% %imwrite(J3,"Bin2.jpg")
%
% % figure,
% % subplot(121);imshow(J4); title('ĺéĺ?')
% % subplot(122);imshow(M); title('ĺéĺ?')
%
%  %% ĺć?ćľĺčžšçź
% J=J3;
% %éĺŽčĺ´
% col0=circle_in_x;row0=circle_in_y;r0=90*scaling;
% for i=1:m
%     for j=1:n
%         if ((i-row0)^2+(j-col0)^2)>=r0^2
%             J(i,j)=0;
%         end
%     end
% end
%
% %imshow(J)
%
%
% mean_circle1=hough_circle2(J,1,0.0524,30*scaling,80*scaling);
%
% % mean_circle1=mean_circle1/scaling;%čżĺ
% % figure,
% % imshow(P);
% % plot_circle(mean_circle1);
%
% %% ĺć?ćľĺ?čžšçź?
%
% %çźŠĺ°čŽĄçŽčĺ´
% row0=mean_circle1(1);col0=mean_circle1(2);r0=mean_circle1(3);
% for i=1:m
%     for j=1:n
%         if (((i-row0)^2+(j-col0)^2)>=(140*scaling)^2)||abs(row0-i) ...
%             >=r0||(((i-row0)^2+(j-col0)^2)<=(70*scaling)^2)
%             J3(i,j)=0;
%         end
%     end
% end
% %imshow(BW)
% %
% % for i=1:m
% %     for j=1:n
% %         if (((i-row0)^2+(j-col0)^2)>=(140*scaling)^2)||(((i-row0)^2+(j-col0)^2)<=(70*scaling)^2)
% %             M(i,j)=0;
% %         end
% %     end
% % end
% % figure,
% % subplot(121);imshow(M); title('ĺĺž')
% % subplot(122);imshow(J3);title('ĺ¤çĺ?')
% mean_circle2=hough_circle2(J3,1,0.0524,100*scaling,140*scaling);
%
% %% ä˝ĺž
% figure,
% imshow(I0);
% plot_circle(mean_circle1./scaling);
% plot_circle(mean_circle2./scaling);

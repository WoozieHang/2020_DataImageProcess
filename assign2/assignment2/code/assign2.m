clc;
close all;
D0=10;
InitialImage=imread('../asset/436.tif');
%原始图片
subplot(2,4,1);imshow(InitialImage);title('原图');
[M,N]=size(InitialImage);
P=2*M;
Q=2*N;

%补零
paddingImage=double(zeros(P,Q));
paddingImage(1:M,1:N)=InitialImage;
subplot(2,4,2);imshow(uint8(paddingImage));title('补零图');

%在空间域中心化频域
centerImage=int8(zeros(P,Q));
for i=1:1:P
for j=1:1:Q
    centerImage(i,j)=((-1)^(i+j))*paddingImage(i,j);
end
end

%在频域调库也可以中心化
%centerImage=(real(ifft2(fftshift(fft2(double(zeroImage),P,Q)))));


subplot(2,4,3);imshow(uint8(centerImage));title('中心化');

%中心化后的原图频谱
flourier_Image=fft2(double(centerImage));
%频谱把复数取模取log+1，再取uint8
subplot(2,4,4);imshow(uint8(log(abs(flourier_Image))+1),[]);title('原图频谱');

%高斯低通滤波器
filter=fftshift(fft2(double(fspecial('gaussian',[P Q],D0)),P,Q));
subplot(2,4,5);imshow(uint8(log(abs(filter))+1),[]);title('中心对称高斯频谱');

%乘法操作
img_filter = filter.*flourier_Image;
subplot(2,4,6);imshow(uint8(log(abs(img_filter))+1),[]);title('乘积过滤后频谱');

%去中心化另一种方式，在频域去中心化
% img_filter=ifftshift(img_filter);

%反傅里叶变换,并取实数部分
img_filter2=fftshift(round(real(ifft2(img_filter))));  

%去中心化，在空间域操作
for i=1:1:P
for j=1:1:Q
    img_filter2(i,j)=((-1)^(i+j))*img_filter2(i,j);
end
end

subplot(2,4,7);imshow(uint8(img_filter2));title('去中心化后的IDFT');

%截断
img_filter3=img_filter2(1:1:M,1:1:N);
subplot(2,4,8);imshow(uint8(img_filter3));title('截断后的结果图');


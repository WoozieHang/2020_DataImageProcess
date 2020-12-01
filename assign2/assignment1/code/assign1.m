clc;
close all;
D0=20;
InitialImage=imread('../asset/432.tif');
%原始图片
[M,N]=size(InitialImage);
P=2*M;
Q=2*N;

%原图不补零转换为频谱，并中心化
Image_F1=fftshift(fft2(double(InitialImage)));
%原图补零转换为频谱，并中心化
Image_F2=fftshift(fft2(double(InitialImage),P,Q));

%MxN的高斯频域滤波器，同样要中心化
filter1=fftshift(fft2(double(fspecial('gaussian',[M N],D0)),M,N));
%PxQ的高斯频域滤波器，同样要中心化
filter2=fftshift(fft2(double(fspecial('gaussian',[P Q],D0)),P,Q));

%频域内做乘法
img_filter1 = filter1.*Image_F1;
img_filter2 = filter2.*Image_F2;

%去中心化
img_filter1=ifftshift(img_filter1);

img_filter1=fftshift(uint8(real(ifft2(img_filter1))));  

%去中心化
img_filter2=ifftshift(img_filter2);    
%反傅里叶变换,并取实数部分
img_filter2=fftshift(uint8(real(ifft2(img_filter2))));  
%截断
img_filter2=img_filter2(1:M,1:N);
subplot(1,3,1);imshow(InitialImage);title('原图');
subplot(1,3,2);imshow(img_filter1);title('不补零高斯低通滤波');
subplot(1,3,3);imshow(img_filter2);title('补零高斯低通滤波');



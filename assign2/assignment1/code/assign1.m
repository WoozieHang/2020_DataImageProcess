clc;
close all;
D0=20;
InitialImage=imread('../asset/432.tif');
%ԭʼͼƬ
[M,N]=size(InitialImage);
P=2*M;
Q=2*N;

%ԭͼ������ת��ΪƵ�ף������Ļ�
Image_F1=fftshift(fft2(double(InitialImage)));
%ԭͼ����ת��ΪƵ�ף������Ļ�
Image_F2=fftshift(fft2(double(InitialImage),P,Q));

%MxN�ĸ�˹Ƶ���˲�����ͬ��Ҫ���Ļ�
filter1=fftshift(fft2(double(fspecial('gaussian',[M N],D0)),M,N));
%PxQ�ĸ�˹Ƶ���˲�����ͬ��Ҫ���Ļ�
filter2=fftshift(fft2(double(fspecial('gaussian',[P Q],D0)),P,Q));

%Ƶ�������˷�
img_filter1 = filter1.*Image_F1;
img_filter2 = filter2.*Image_F2;

%ȥ���Ļ�
img_filter1=ifftshift(img_filter1);

img_filter1=fftshift(uint8(real(ifft2(img_filter1))));  

%ȥ���Ļ�
img_filter2=ifftshift(img_filter2);    
%������Ҷ�任,��ȡʵ������
img_filter2=fftshift(uint8(real(ifft2(img_filter2))));  
%�ض�
img_filter2=img_filter2(1:M,1:N);
subplot(1,3,1);imshow(InitialImage);title('ԭͼ');
subplot(1,3,2);imshow(img_filter1);title('�������˹��ͨ�˲�');
subplot(1,3,3);imshow(img_filter2);title('�����˹��ͨ�˲�');



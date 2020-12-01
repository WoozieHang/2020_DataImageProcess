clc;
close all;
D0=10;
InitialImage=imread('../asset/436.tif');
%ԭʼͼƬ
subplot(2,4,1);imshow(InitialImage);title('ԭͼ');
[M,N]=size(InitialImage);
P=2*M;
Q=2*N;

%����
paddingImage=double(zeros(P,Q));
paddingImage(1:M,1:N)=InitialImage;
subplot(2,4,2);imshow(uint8(paddingImage));title('����ͼ');

%�ڿռ������Ļ�Ƶ��
centerImage=int8(zeros(P,Q));
for i=1:1:P
for j=1:1:Q
    centerImage(i,j)=((-1)^(i+j))*paddingImage(i,j);
end
end

%��Ƶ�����Ҳ�������Ļ�
%centerImage=(real(ifft2(fftshift(fft2(double(zeroImage),P,Q)))));


subplot(2,4,3);imshow(uint8(centerImage));title('���Ļ�');

%���Ļ����ԭͼƵ��
flourier_Image=fft2(double(centerImage));
%Ƶ�װѸ���ȡģȡlog+1����ȡuint8
subplot(2,4,4);imshow(uint8(log(abs(flourier_Image))+1),[]);title('ԭͼƵ��');

%��˹��ͨ�˲���
filter=fftshift(fft2(double(fspecial('gaussian',[P Q],D0)),P,Q));
subplot(2,4,5);imshow(uint8(log(abs(filter))+1),[]);title('���ĶԳƸ�˹Ƶ��');

%�˷�����
img_filter = filter.*flourier_Image;
subplot(2,4,6);imshow(uint8(log(abs(img_filter))+1),[]);title('�˻����˺�Ƶ��');

%ȥ���Ļ���һ�ַ�ʽ����Ƶ��ȥ���Ļ�
% img_filter=ifftshift(img_filter);

%������Ҷ�任,��ȡʵ������
img_filter2=fftshift(round(real(ifft2(img_filter))));  

%ȥ���Ļ����ڿռ������
for i=1:1:P
for j=1:1:Q
    img_filter2(i,j)=((-1)^(i+j))*img_filter2(i,j);
end
end

subplot(2,4,7);imshow(uint8(img_filter2));title('ȥ���Ļ����IDFT');

%�ض�
img_filter3=img_filter2(1:1:M,1:1:N);
subplot(2,4,8);imshow(uint8(img_filter3));title('�ضϺ�Ľ��ͼ');


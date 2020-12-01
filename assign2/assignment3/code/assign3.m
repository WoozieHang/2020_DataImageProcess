clc;
close all;
D0=10;
InitialImage=imread('../asset/3_3.jpg');
[M,N]=size(InitialImage);
P=2*M;
Q=2*N;

%ԭʼͼƬ
subplot(3,3,1);imshow(InitialImage);title('ԭͼ');
%�α��ϵ�sobel�ǿ����ת270��
spaceFilter=rot90(fspecial('sobel'),3);

%���ñ��п���Լ��ľ��ʵ�ֽ��бȽ�
%I2=conv2((Image),double(spaceFilter),'same');   

%ʵ�־����������I2
%�������ת180��
kernel=rot90(spaceFilter,2);
%ԭͼ���ܲ�0
paddingImage=double(zeros(M+4,N+4));
paddingImage(3:1:M+2,3:1:N+2)=double(InitialImage);

%���ڴ�ž�����
convMatrix=double(zeros(M+2,N+2));
%�������
for i=1:M+2
    for j=1:N+2
        for p=0:2
            for q=0:2
                tmp=paddingImage(i+p,j+q)*kernel(1+p,1+q);
                convMatrix(i,j)=convMatrix(i,j)+tmp;
            end
        end
    end
end
%�ضϾ�����
convMatrix2=(convMatrix(2:M+1,2:N+1));
subplot(3,3,2);imshow(convMatrix2,[]);title('�ռ����˲�����ͼ');

%��ʵ��Ƶ���˲�
zeroImage=double(zeros(P,Q));
zeroImage(1:M,1:N)=InitialImage;
subplot(3,3,3);imshow(uint8(zeroImage));title('����ͼ');

%�ڿռ������Ļ��ķ���
% centerImage=int8(zeros(P,Q));
% for i=1:1:P
% for j=1:1:Q
%     centerImage(i,j)=((-1)^(i+j))*zeroImage(i,j);
% end
% end

%�����������Ƶ�����Ļ��ķ�������assign2��ʹ�õ�ǰ�ַ�������ʹ��
centerImage=(real(ifft2(fftshift(fft2(double(zeroImage),P,Q)))));
subplot(3,3,4);imshow(uint8(centerImage));title('���Ļ�');

%ԭͼƵ��
flourier_Image=fft2(double(centerImage));
subplot(3,3,5);imshow(uint8(log(abs(flourier_Image))+1),[]);title('ԭͼƵ��');
%�任ģ�嵽Ƶ��
filter=fftshift(fft2(double(spaceFilter),P,Q));
subplot(3,3,6);imshow(uint8(log(abs(filter))+1),[]);title('sobelģ��Ƶ��');
%�˷�����
img_filter = filter.*flourier_Image;
subplot(3,3,7);imshow(uint8(log(abs(img_filter))+1),[]);title('�˻����˺�Ƶ��');

%��Ƶ��ȥ���Ļ�
img_filter=ifftshift(img_filter);
%������Ҷ�任,��ȡʵ������
img_filter2=round(real(ifft2(img_filter)));  

%Ҳ���ڿռ������Ļ�
% for i=1:1:P
% for j=1:1:Q
%     img_filter2(i,j)=((-1)^(i+j))*img_filter2(i,j);
% end
% end
subplot(3,3,8);imshow(img_filter2,[]);title('ȥ���Ļ����IDFT');
%�ضϺ�õ�Ƶ�����˲����
img_filter3=img_filter2(1:1:M,1:1:N);
subplot(3,3,9);imshow(img_filter3,[]);title('Ƶ�����˲�����ͼ');
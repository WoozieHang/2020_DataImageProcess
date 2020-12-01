clc;
close all;
D0=10;
InitialImage=imread('../asset/3_3.jpg');
[M,N]=size(InitialImage);
P=2*M;
Q=2*N;

%原始图片
subplot(3,3,1);imshow(InitialImage);title('原图');
%课本上的sobel是库的旋转270度
spaceFilter=rot90(fspecial('sobel'),3);

%可用本行库和自己的卷积实现进行比较
%I2=conv2((Image),double(spaceFilter),'same');   

%实现卷积代替上面I2
%卷积核旋转180度
kernel=rot90(spaceFilter,2);
%原图四周补0
paddingImage=double(zeros(M+4,N+4));
paddingImage(3:1:M+2,3:1:N+2)=double(InitialImage);

%用于存放卷积结果
convMatrix=double(zeros(M+2,N+2));
%卷积计算
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
%截断卷积结果
convMatrix2=(convMatrix(2:M+1,2:N+1));
subplot(3,3,2);imshow(convMatrix2,[]);title('空间域滤波处理图');

%再实现频域滤波
zeroImage=double(zeros(P,Q));
zeroImage(1:M,1:N)=InitialImage;
subplot(3,3,3);imshow(uint8(zeroImage));title('补零图');

%在空间域中心化的方法
% centerImage=int8(zeros(P,Q));
% for i=1:1:P
% for j=1:1:Q
%     centerImage(i,j)=((-1)^(i+j))*zeroImage(i,j);
% end
% end

%本代码采用在频域中心化的方法，和assign2中使用的前种方法交替使用
centerImage=(real(ifft2(fftshift(fft2(double(zeroImage),P,Q)))));
subplot(3,3,4);imshow(uint8(centerImage));title('中心化');

%原图频谱
flourier_Image=fft2(double(centerImage));
subplot(3,3,5);imshow(uint8(log(abs(flourier_Image))+1),[]);title('原图频谱');
%变换模板到频域
filter=fftshift(fft2(double(spaceFilter),P,Q));
subplot(3,3,6);imshow(uint8(log(abs(filter))+1),[]);title('sobel模板频谱');
%乘法操作
img_filter = filter.*flourier_Image;
subplot(3,3,7);imshow(uint8(log(abs(img_filter))+1),[]);title('乘积过滤后频谱');

%在频域去中心化
img_filter=ifftshift(img_filter);
%反傅里叶变换,并取实数部分
img_filter2=round(real(ifft2(img_filter)));  

%也可在空间域中心化
% for i=1:1:P
% for j=1:1:Q
%     img_filter2(i,j)=((-1)^(i+j))*img_filter2(i,j);
% end
% end
subplot(3,3,8);imshow(img_filter2,[]);title('去中心化后的IDFT');
%截断后得到频率域滤波结果
img_filter3=img_filter2(1:1:M,1:1:N);
subplot(3,3,9);imshow(img_filter3,[]);title('频率域滤波处理图');
clc
clear
close all

initial_Image = imread('../asset/woman.png');

%核的高为2*L+1
L=7;
%核的宽为2*K+1
K=7;
%高斯核方差
d1 = 7;
%权重核方差
d2 = 0.07;

%填充0
[m,n]=size(initial_Image);
padding_Image=double(zeros(m+4*L,n+4*K));
padding_Image(2*L+1:2*L+m,2*K+1:2*K+n)=initial_Image;

%映射到[0,1]区间
padding_Image=padding_Image/255;

subplot(1,2,1);imshow(initial_Image);title('原图')

%高斯核模板定义
gauss = fspecial('gauss',[2*L+1,2*K+1],d1);

%美颜结果图初始化，之后由加权核和高斯核乘法操作得到加权高斯核,然后卷积
outImage=double(zeros(m,n));

for i = 1 : m
    for j = 1 : n
       %获取ij对应区域的梯度矩阵
       t1=padding_Image(i:i+2*L,j:j+2*K);
       t2 = abs( t1- padding_Image(i+L,j+K));
       t3 = exp(-t2.^2/(2*d2^2));
       
       %加权核乘高斯核得到双边滤波器
       filter = gauss.*t3;
       %按公式进行标准化
       filter = filter/sum(filter(:));
       
       %加权卷积计算
       for p=0:2*L
        for q=0:2*K
            outImage(i,j)=outImage(i,j)+padding_Image(i+p,j+q)*filter(1+p,1+q);
        end
       end
    end
end

subplot(1,2,2);imshow(outImage);title('美颜处理图')


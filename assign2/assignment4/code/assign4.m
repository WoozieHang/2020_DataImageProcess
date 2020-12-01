clc
clear
close all

initial_Image = imread('../asset/woman.png');

%�˵ĸ�Ϊ2*L+1
L=7;
%�˵Ŀ�Ϊ2*K+1
K=7;
%��˹�˷���
d1 = 7;
%Ȩ�غ˷���
d2 = 0.07;

%���0
[m,n]=size(initial_Image);
padding_Image=double(zeros(m+4*L,n+4*K));
padding_Image(2*L+1:2*L+m,2*K+1:2*K+n)=initial_Image;

%ӳ�䵽[0,1]����
padding_Image=padding_Image/255;

subplot(1,2,1);imshow(initial_Image);title('ԭͼ')

%��˹��ģ�嶨��
gauss = fspecial('gauss',[2*L+1,2*K+1],d1);

%���ս��ͼ��ʼ����֮���ɼ�Ȩ�˺͸�˹�˳˷������õ���Ȩ��˹��,Ȼ����
outImage=double(zeros(m,n));

for i = 1 : m
    for j = 1 : n
       %��ȡij��Ӧ������ݶȾ���
       t1=padding_Image(i:i+2*L,j:j+2*K);
       t2 = abs( t1- padding_Image(i+L,j+K));
       t3 = exp(-t2.^2/(2*d2^2));
       
       %��Ȩ�˳˸�˹�˵õ�˫���˲���
       filter = gauss.*t3;
       %����ʽ���б�׼��
       filter = filter/sum(filter(:));
       
       %��Ȩ�������
       for p=0:2*L
        for q=0:2*K
            outImage(i,j)=outImage(i,j)+padding_Image(i+p,j+q)*filter(1+p,1+q);
        end
       end
    end
end

subplot(1,2,2);imshow(outImage);title('���մ���ͼ')


%test histeq
%ͼƬ����ѡ��color1��color2��color3��color4��gray1��gray2��gray3��gray4
I = imread('..\asset\image\gray1.jpg');
%����ǲ�ͼ���ڶ��������ķ�Χ��0��1��2��3��4��5; �ֱ��Ӧ�ţ���ʼͼ��Ĭ�Ϸ���hsi������ֵ����YCbCr�����⺯����
%����ǻҶ�ͼ,�ڶ��������ķ�ΧҲ��0-5��0�����ʼͼ��5����⺯������1-4û�����𣬶�����ʵ�ֵĻҶ�ͼ���⻯����
[J] = Histogram_equalization(I,0);
figure, imshow(J);
%     �����Ҫ�鿴ֱ��ͼ�ֲ�����ȡ������2��ע��
%     figure,imshow(J)
%     imhist(J(:,:,1));



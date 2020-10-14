%test histeq
%图片可以选择color1、color2、color3、color4、gray1、gray2、gray3、gray4
I = imread('..\asset\image\gray1.jpg');
%如果是彩图，第二个参数的范围是0、1、2、3、4、5; 分别对应着：初始图、默认法、hsi法、均值法、YCbCr法、库函数法
%如果是灰度图,第二个参数的范围也是0-5，0代表初始图，5代表库函数法，1-4没有区别，都是自实现的灰度图均衡化方法
[J] = Histogram_equalization(I,0);
figure, imshow(J);
%     如果需要查看直方图分布，可取消以下2行注释
%     figure,imshow(J)
%     imhist(J(:,:,1));



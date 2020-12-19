%DIP16 Assignment 2
%Edge Detection
%In this assignment, you should build your own edge detection and edge linking 
%function to detect the edges of a image.
%Please Note you cannot use the build-in matlab edge and bwtraceboundary function
%We supply four test images, and you can use others to show your results for edge
%detection, but you just need do edge linking for rubberband_cap.png.
clc; clear all;
% Load the test image
tmp=imread('../asset/image/rubberband_cap.png');
imgTest = im2double(tmp);
imgTestGray = rgb2gray(imgTest);
figure; clf;
imshow(imgTestGray);title('原图');

%now call your function my_edge, you can use matlab edge function to see
%the last result as a reference first
img_edge0 = edge(imgTestGray);
figure;clf;
imshow(img_edge0);title('matlab自带库');

img_edge1 = my_edge(imgTestGray,1);
figure;clf;
imshow(img_edge1);title('sobel基本法');
img_edge2 = my_edge(imgTestGray,2);
figure;clf;
imshow(img_edge2);title('Marr-Hildreth边缘检测器');

img_edge = my_edge(imgTestGray,3);
figure;clf;
imshow(img_edge);title('Canny边缘检测器');


% %以下代码用于对rubberband_cap.png进行边缘连接，当图片为其他时可注释以下代码

background = im2bw(imgTest, 1);
figure;clf
imshow(background);title('边缘连接显示');
%using imtool, you select a object boundary to trace, and choose
%an appropriate edge point as the start point 
imtool(img_edge);
%now call your function my_edgelinking, you can use matlab bwtraceboundary 
%function to see the last result as a reference first. please trace as many 
%different object boundaries as you can, and choose different start edge points.
%Bxpc = bwtraceboundary(img_edge, [197, 327], 'N');

Bxpc = my_edgelinking(img_edge, 139, 65);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'r', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 156, 95);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'g', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 196, 80);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'b', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 165, 324);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'c', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 283, 233);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'm', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 94, 298);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'y', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 90, 299);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'w', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 141, 441);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'r', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 178, 407);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'g', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 162, 393);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'b', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 145, 387);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'c', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 161, 432);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'm', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 175, 431);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'y', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 177, 428);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'w', 'LineWidth', 1);

Bxpc = my_edgelinking(img_edge, 175, 409);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'r', 'LineWidth', 1);

clear all;
I = imread( 'Window.png');  % 读取图像
rH = 0.5;   rL = 0.3;
c = 2;      D0 = 20;        % 定义函数使用的高通滤波参数

J = Homomorphic_filter( I, rH, rL, c, D0);        % 调用同态滤波函数

subplot(2,2,1);imshow(I);title('原始图像');
subplot(2,2,2);imshow(J);title('最终图像');
subplot(2,2,3);imhist(I);title('原始图像直方图');
subplot(2,2,4);imhist(J);title('最终图像直方图');
% 画图
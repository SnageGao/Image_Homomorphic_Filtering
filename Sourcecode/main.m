clear all;
I = imread( 'Window.png');  % ��ȡͼ��
rH = 0.5;   rL = 0.3;
c = 2;      D0 = 20;        % ���庯��ʹ�õĸ�ͨ�˲�����

J = Homomorphic_filter( I, rH, rL, c, D0);        % ����̬ͬ�˲�����

subplot(2,2,1);imshow(I);title('ԭʼͼ��');
subplot(2,2,2);imshow(J);title('����ͼ��');
subplot(2,2,3);imhist(I);title('ԭʼͼ��ֱ��ͼ');
subplot(2,2,4);imhist(J);title('����ͼ��ֱ��ͼ');
% ��ͼ
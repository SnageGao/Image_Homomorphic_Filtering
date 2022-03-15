% ���룺Image_Target [m*n*k (uint8)]ΪĿ��ͼ�� k=1ʱΪ�ڰ�ͼ��k=3ʱΪ��ɫͼ��
%       rH��rL (double) Ϊ���������ͨ�˲���������������
%       c (double) Ϊ��ͨ�˲������ɲ��ֵ�������
%       D0 (uint) Ϊ��ֹƵ�ʵ�ԭ��ľ���
% �����Image_Final [m*n*k (uint8)]Ϊ̬ͬ�˲����ͼ��
% �������ܣ��������ͼ���������ĸ�ͨ�˲���������̬ͬ�˲�����
function Image_final = Homomorphic_filter( Image_target, rH, rL, c, D0)

% ���峣������
[ H, W, K] = size( Image_target);       % ����Ŀ��ͼƬ�ߴ�
Shift = ((-1).^(1:H)')*((-1).^(1:W));   % ����Ҷ�任ԭ����о���
                                        % Shift(x,y) = (-1)^(x+y)
X2 = ((1:H)-round(H/2))' * ones(1,W);
Y2 = ones(H,1) * ((1:W)-round(W/2)) ;
D = ( X2.^2 + Y2.^2 ).^0.5;             % �����ԭ��������
                                        % D(x,y) = ((x-W/2)^2+(y-H/2)^2)^0.5
                                  
% ȡ����������Ҷ�任
Image_d = im2double(Image_target + 1); % ת��Ϊ0~1��double���ͣ�+1����0ֵ
Image_ln = log( Image_d);               % ��������
Image_fft = fft2( Image_ln.* Shift);    % ����ת������֮����и���Ҷ�任


% H��ȡ���˲�
Hxy = (rH-rL)*(1-exp(-c*D.^2/D0^2))+rL; % �����ͨ�˲�����
Hxy = repmat( Hxy, [1,1,K]);            % ����ͼ��ͨ������������ά
Image_fil = Image_fft .* Hxy;           % �˲�

    
% ������Ҷ�任��ȡָ��
Image_ifft = real(ifft2(Image_fil));    % ����Ҷ���任
Image_exp = exp(Image_ifft.*Shift);     % ����ת�������ȡָ��


Image_final = Image_exp;                % ���Ϊ����ͼ��






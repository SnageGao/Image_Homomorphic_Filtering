% 输入：Image_Target [m*n*k (uint8)]为目标图像 k=1时为黑白图像，k=3时为彩色图像
%       rH，rL (double) 为函数所需高通滤波器的上限与下限
%       c (double) 为高通滤波器过渡部分的锐利度
%       D0 (uint) 为截止频率到原点的距离
% 输出：Image_Final [m*n*k (uint8)]为同态滤波后的图像
% 函数功能：对输入的图像根据输入的高通滤波参数进行同态滤波操作
function Image_final = Homomorphic_filter( Image_target, rH, rL, c, D0)

% 定义常量参数
[ H, W, K] = size( Image_target);       % 计算目标图片尺寸
Shift = ((-1).^(1:H)')*((-1).^(1:W));   % 傅里叶变换原点居中矩阵
                                        % Shift(x,y) = (-1)^(x+y)
X2 = ((1:H)-round(H/2))' * ones(1,W);
Y2 = ones(H,1) * ((1:W)-round(W/2)) ;
D = ( X2.^2 + Y2.^2 ).^0.5;             % 计算距原点距离矩阵
                                        % D(x,y) = ((x-W/2)^2+(y-H/2)^2)^0.5
                                  
% 取对数、傅里叶变换
Image_d = im2double(Image_target + 1); % 转换为0~1的double类型，+1消除0值
Image_ln = log( Image_d);               % 对数运算
Image_fft = fft2( Image_ln.* Shift);    % 乘以转换矩阵之后进行傅里叶变换


% H获取、滤波
Hxy = (rH-rL)*(1-exp(-c*D.^2/D0^2))+rL; % 计算高通滤波函数
Hxy = repmat( Hxy, [1,1,K]);            % 根据图像通道数将函数扩维
Image_fil = Image_fft .* Hxy;           % 滤波

    
% 反傅里叶变换、取指数
Image_ifft = real(ifft2(Image_fil));    % 傅里叶反变换
Image_exp = exp(Image_ifft.*Shift);     % 乘以转换矩阵后取指数


Image_final = Image_exp;                % 输出为最终图像






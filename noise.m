% 聂影 USM MECH 20230731 
% 论文图8,给剪切后的图像添加噪声
% 设置文件夹路径
input_folder = 'K:\MyPaper\Turbidity\imageData\729\cut\10';
gaussian_folder = 'K:\MyPaper\Turbidity\imageData\729\cut\gaussic\10';
salt_folder = 'K:\MyPaper\Turbidity\imageData\729\cut\salt\10';
joint_folder = 'K:\MyPaper\Turbidity\imageData\729\cut\joint\10';

% 检查并创建文件夹
if ~exist(input_folder, 'dir')
    error('Input folder does not exist.');
end

if ~exist(gaussian_folder, 'dir')
    mkdir(gaussian_folder);
end

if ~exist(salt_folder, 'dir')
    mkdir(salt_folder);
end

if ~exist(joint_folder, 'dir')
    mkdir(joint_folder);
end

% 获取文件夹中的所有图像文件
image_files = dir(fullfile(input_folder, '*.jpg'));

% 遍历图像文件
for i = 1:numel(image_files)
    % 读取图像
    image_path = fullfile(input_folder, image_files(i).name);
    original_image = imread(image_path);

    % 添加高斯噪声
    gaussian_noise = imnoise(original_image, 'gaussian', 0, 0.01);
    % 保存图像到高斯噪声文件夹
    [~,name,ext] = fileparts(image_files(i).name);
    imwrite(gaussian_noise, fullfile(gaussian_folder, [name, '_gaussic', ext]));

    % 添加椒盐噪声
    salt_and_pepper_noise = imnoise(original_image, 'salt & pepper', 0.05);
    % 保存图像到椒盐噪声文件夹
    imwrite(salt_and_pepper_noise, fullfile(salt_folder, [name, '_salt', ext]));

    % 添加混合噪声
    mixed_noise = imnoise(original_image, 'salt & pepper', 0.03);
    mixed_noise = imnoise(mixed_noise, 'gaussian', 0, 0.01);
    % 保存图像到混合噪声文件夹
    imwrite(mixed_noise, fullfile(joint_folder, [name, '_joint', ext]));

    fprintf('Processed image: %s\n', image_files(i).name);
end

disp('Noise generation and saving completed.');


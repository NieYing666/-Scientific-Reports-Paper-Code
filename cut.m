% 浊度图片批量剪切，像素128*128
% 聂影 于 USM MECH 20230630

% 原始文件夹路径和剪切后存放文件夹路径
originalFolderPath = 'K:\MyPaper\Turbidity\imageData\729\label\10';
cutFolderPath = 'K:\MyPaper\Turbidity\imageData\729\cut\10';

% 获取文件夹中的所有图像文件
imageFiles = dir(fullfile(originalFolderPath, '*.jpg'));

% 创建剪切后存放文件夹
if ~exist(cutFolderPath, 'dir')
    mkdir(cutFolderPath);
end

% 遍历图像文件并进行剪切
for i = 1:length(imageFiles)
    % 读取原图像
    originalImagePath = fullfile(originalFolderPath, imageFiles(i).name);
    originalImage = imread(originalImagePath);
    
    % 获取图像尺寸
    [height, width, ~] = size(originalImage);
    
    % 计算剪切区域的位置
    x = floor((width - 128) / 2) + 1;
    y = floor((height - 128) / 2) + 1;
    
    % 剪切图像为128x128像素
    croppedImage = imcrop(originalImage, [x, y, 127, 127]);
    
    % 生成新文件名
    [~, imageName, imageExt] = fileparts(imageFiles(i).name);
    newImageName = [imageName, imageExt];
    
    % 保存剪切后的图像
    cutImagePath = fullfile(cutFolderPath, newImageName);
    imwrite(croppedImage, cutImagePath);
end



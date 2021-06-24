origIm =imread('C:\Users\xiang he\Desktop\CV大作业-2021-双学位\Image Segmentation provided-files\Image Segmentation provided-files\snake.jpg');

[height,width] = size(origIm);
%subplot(3,1,1);
imshow(origIm)
title('原图像');
%bank = load('filterBank.mat');
bank = cell2mat(struct2cell(load('filterBank.mat'))); %直接load无法进行displayFilterBank的操作
bankSubset=[];
bankSubset = bank(:,:,38); %最后一个维度选择用谁
%displayFilterBank(bank)

imStack = {rgb2gray(origIm)} ;    
useSubsetOrNot = 0; %是否使用bank子集的变量，假为0
if useSubsetOrNot
    bank = bankSubset;
end
[m,n,l] =size(bank);
winSize = 10;
numColorRegions = 3;  % 聚类数
numTextureRegions = 3 ;   % 聚类数
 
k = 10;   %纹理基元的纹理编码集个数
textons = createTextons(imStack, bank, k);

[colorLabelIm, textureLabelIm] = compareSegmentations(origIm, bank, textons, winSize, numColorRegions, numTextureRegions);

%subplot(3,1,2);
figure(2)
imagesc(colorLabelIm)
hold on;
colorbar
title('颜色分割');
%subplot(3,1,3);
figure(3)
imagesc(textureLabelIm)
colorbar  %定义图例位置大小
title('纹理分割');
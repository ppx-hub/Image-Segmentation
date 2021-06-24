function [colorLabelIm, textureLabelIm] = compareSegmentations(origIm, bank, textons, winSize, numColorRegions, numTextureRegions)

origIm = im2double(origIm);

colorSet = reshape(origIm, size(origIm, 1)*size(origIm, 2), size(origIm, 3)); %获取颜色集
opts = statset('Display','final','MaxIter',1000);
[~, colorCenter] = kmeans(colorSet, numColorRegions, 'Options', opts); %将颜色集分为numColorRegions类
colorLabelIm = quantizeFeats(origIm, colorCenter);

featIm = extractTextonHists(rgb2gray(origIm), bank, textons, winSize); %获取纹理特征图
featImSet = reshape(featIm, size(featIm, 1)*size(featIm, 2), size(featIm, 3));
[~, textureCenter] = kmeans(featImSet, numTextureRegions, 'Options', opts); %将纹理特征分为numTextureRegions类
textureLabelIm = quantizeFeats(featIm, textureCenter);

return;
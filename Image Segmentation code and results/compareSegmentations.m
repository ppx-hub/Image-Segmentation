function [colorLabelIm, textureLabelIm] = compareSegmentations(origIm, bank, textons, winSize, numColorRegions, numTextureRegions)

origIm = im2double(origIm);

colorSet = reshape(origIm, size(origIm, 1)*size(origIm, 2), size(origIm, 3)); %��ȡ��ɫ��
opts = statset('Display','final','MaxIter',1000);
[~, colorCenter] = kmeans(colorSet, numColorRegions, 'Options', opts); %����ɫ����ΪnumColorRegions��
colorLabelIm = quantizeFeats(origIm, colorCenter);

featIm = extractTextonHists(rgb2gray(origIm), bank, textons, winSize); %��ȡ��������ͼ
featImSet = reshape(featIm, size(featIm, 1)*size(featIm, 2), size(featIm, 3));
[~, textureCenter] = kmeans(featImSet, numTextureRegions, 'Options', opts); %������������ΪnumTextureRegions��
textureLabelIm = quantizeFeats(featIm, textureCenter);

return;
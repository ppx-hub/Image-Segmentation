origIm =imread('C:\Users\xiang he\Desktop\CV����ҵ-2021-˫ѧλ\Image Segmentation provided-files\Image Segmentation provided-files\snake.jpg');

[height,width] = size(origIm);
%subplot(3,1,1);
imshow(origIm)
title('ԭͼ��');
%bank = load('filterBank.mat');
bank = cell2mat(struct2cell(load('filterBank.mat'))); %ֱ��load�޷�����displayFilterBank�Ĳ���
bankSubset=[];
bankSubset = bank(:,:,38); %���һ��ά��ѡ����˭
%displayFilterBank(bank)

imStack = {rgb2gray(origIm)} ;    
useSubsetOrNot = 0; %�Ƿ�ʹ��bank�Ӽ��ı�������Ϊ0
if useSubsetOrNot
    bank = bankSubset;
end
[m,n,l] =size(bank);
winSize = 10;
numColorRegions = 3;  % ������
numTextureRegions = 3 ;   % ������
 
k = 10;   %�����Ԫ��������뼯����
textons = createTextons(imStack, bank, k);

[colorLabelIm, textureLabelIm] = compareSegmentations(origIm, bank, textons, winSize, numColorRegions, numTextureRegions);

%subplot(3,1,2);
figure(2)
imagesc(colorLabelIm)
hold on;
colorbar
title('��ɫ�ָ�');
%subplot(3,1,3);
figure(3)
imagesc(textureLabelIm)
colorbar  %����ͼ��λ�ô�С
title('����ָ�');
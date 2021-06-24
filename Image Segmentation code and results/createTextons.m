function [textons] = createTextons(imStack, bank, k)
[r,c] = size(imStack);  %row、col
n = size(bank,3);   %filter num

textonsSet=[];
for i=1:r
    for j = 1:c
        im = imStack{i,j}; %cell
        im = im2double(im);
        res = zeros(size(im,1),size(im,2),n);    %filter result
        for channel = 1:n
            res(:,:,channel) = conv2(im,double(bank(:,:,channel)),'same');
        end
        numpixels = size(res,1) * size(res,2);
        X = reshape(res,numpixels,n);% yield a matrix with the RGB features as its rows
        %textonsSet = [textonsSet;X];    %use all pixels’ filter responses to be clustered (use more time)
        first = size(X,1);
        randomX = X(randperm(first,ceil(first/1000)),:);
        textonsSet = [textonsSet;randomX];
    end
end

%使用自带的kmeans，对纹理编码进行k个聚类
[~,textons] = kmeans(textonsSet,k);
return;
        
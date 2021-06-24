function [featIm] = extractTextonHists(origIm, bank, textons, winSize)

origIm = im2double(origIm);
[r, c] = size(origIm);

n = size(bank, 3);
res = zeros(r, c, n);
for row=1:n
    res(:,:,row)=conv2(origIm,double(bank(:,:,row)),'same');
end

X = reshape(res, size(res,1)* size(res,2), n);  % 前面操作与之前函数相同
dis2textons = dist2(textons, X);    %计算纹理集和res距离
[~, argtexton] = min(dis2textons); %取最小
temptexton = reshape(argtexton, r, c);

if winSize > 1
    Num_Left = floor((winSize-1)/2);
    Num_Right = ceil((winSize-1)/2);
    for i=1:Num_Left
        temptexton = [temptexton(:,1), temptexton];
        temptexton = [temptexton(1,:); temptexton];
    end
    for i=1:Num_Right
        temptexton = [temptexton, temptexton(:,size(temptexton, 2))];
        temptexton = [temptexton; temptexton(size(temptexton, 1), :)];
    end
else
    Num_Left = 0;
    Num_Right = 0;
end

featIm = zeros(r, c, size(textons, 1));
for i=(1+Num_Left):(size(temptexton, 1)-Num_Right)
    for j=(1+Num_Left):(size(temptexton, 2)-Num_Right)
        window = temptexton((i-Num_Left):(i+Num_Right), (j-Num_Left):(j+Num_Right));
        frequency = tabulate(window(:));
        for k=1:size(frequency, 1)
            textonIndex = int64(frequency(k, 1));
            count = int32(frequency(k, 2));
            featIm(i-Num_Left, j-Num_Left, textonIndex) = featIm(i-Num_Left, j-Num_Left, textonIndex)+count;
        end
    end
end
        
return;
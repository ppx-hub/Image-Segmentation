function [labelIm] = quantizeFeats(featIm, meanFeats)

[h,w,d] = size(featIm); %height、width、dimension
k = size(meanFeats,1)
labelIm = ones(h,w);   %h*w

for i = 1:h
    for j = 1:w
        minDis = 10000000;
        for m = 1:k
            tempDis = 0;
            for n = 1:d
                tempDis = tempDis + power(featIm(i,j,n)-meanFeats(m,n),2);
            end
            tempDis = sqrt(tempDis); %欧式距离
            if tempDis < minDis
                labelIm(i,j) = m; %划分聚类中心
                minDis = tempDis;       
            end
        end
    end
end
return
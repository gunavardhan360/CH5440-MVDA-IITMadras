%code by GUNAVARDHAN REDDY (CH18B035)
clc; clear all;
%reading images
folder = 'yalefaces\';
files = dir(folder);
files = files(~[files.isdir]);
images = zeros(243*320,6,15);
for k = 3:92
    im2 = imread(fullfile(folder, files(k).name));
    i = int16(fix((k-3)/6)) + 1;
    j = rem(k,6);
    if j == 0
        j = 6;
    end
    images(:,j,i) = reshape(im2,[],1);
end

%pca analysis and scores vector after autoscaling
repimages = zeros(243*320,15);
pcamatrix = zeros(243*320,6);
for i = 1:15
    for j = 1:6
        pcamatrix(:,j) = (images(:,j,i)-mean(images(:,j,i)))./std(images(:,j,i));
    end
    [V U] = eig(pcamatrix'*pcamatrix);
    repimages(:,i) = pcamatrix*V(:,6);
end

%matching the images with representative images
min = 1000;
temp = 0;
found = 0;
match1 = 0;
vector = zeros(243*320,1);
for i = 1:15
    for j = 1:6
        min = 1000;
        vector = images(:,j,i);
        vectorshifted = (vector- mean(vector))./std(vector);
        for k = 1:15
            temp = norm(vectorshifted - repimages(:,k));
            if temp < min
                min = temp;
                found = k;
            end
        end
        if found == i
            match1 = match1 +1;
        end
    end
end
repimages(:,1);
match1
%match1 is 70

%reading test data
testimages = zeros(243*320,5,15);
for k = 93:167
    im2 = imread(fullfile(folder, files(k).name));
    i = int16(fix((k-93)/5)) + 1;
    j = rem(k,5);
    if j == 0
        j = 5;
    end
    testimages(:,j,i) = reshape(im2,[],1);
end

%matching test data
min = 10000;
temp = 0;
found = 0;
match2 = 0;
vector = zeros(243*320,1);
for i = 1:15
    for j = 1:5
        min = 10000;
        vector = testimages(:,j,i);
        vectorshifted = (vector- mean(vector))./std(vector);
        for k = 1:15
            temp = norm(vectorshifted - repimages(:,k));
            if temp < min
                min = temp;
                found = k;
            end
        end
        if found == i
            match2 = match2 +1;
        end
    end
end
repimages(:,1);
match2
%match2 is obtained as 54

match = match1 + match2
%match is obtained as 124
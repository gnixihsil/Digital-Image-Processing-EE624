function que1

% Read images
a = imread('givenhist.jpg');
figure; imshow(a); title('given histogram');
b = imread('sphist.jpg');
figure; imshow(b); title('specified histogram');

% Reshape to form a column matrix
A = double(reshape(a,1,256*512));
B = double(reshape(b,1,256*512));

% histogram formation
h1 = double(hist(A,256));
h2 = double(hist(B,256));

% To attain pdf
nh1 = h1/sum(h1);
nh2 = h2/sum(h2);

% intializing cdf and attaining them
c1 = nh1;
c2 = nh2;
for i=2:256
    c1(i) = c1(i-1)+nh1(i);
    c2(i) = c2(i-1)+nh2(i);
end
% c1 = round(c1*255);
% c2 = round(c2*255);
c1 = (c1*255);
c2 = (c2*255);

% mapping r and z 
index = ones(1,256);
temp = ones(1,256);
for i=1:256
temp = abs(c2-c1(i)*ones(1,256));
[~,index(i)] = min(temp);
end

%initializing output image
new = a-a;
for i=1:256
    for j=1:512
        if (a(i,j)==0)
            new(i,j)=30;
        else
        new(i,j)=index(a(i,j));
        end
    end
end

 figure ;imshow(new); title('histogram specified image');

end
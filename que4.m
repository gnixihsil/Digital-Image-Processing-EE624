%%
clear all;
clc;
%%
%loading input image
img=imread('IITG.jpg');
img=rgb2gray(img);

%initializing neccessary output images
r=zeros(size(img)-4);
img_x=zeros(size(img));
img_y=zeros(size(img));
[p,q]=size(img);

img=padarray(img,[1,1],'both');
[n,m]=size(img);

%horizontal gradient image
for i=2:n-1
   img_x(i-1,:)=img(i+1,2:m-1)-img(i-1,2:m-1); 
end

%vertical gradient image
for i=2:m-1
   img_y(:,i-1)=img(2:n-1,i+1)-img(2:n-1,i-1); 
end

% 5x5 filter for detecting corners 
window_x=repmat(-2:2,5,1);
window_y=repmat((-2:2)',1,5);

%default value of alpha in corner response function
alpha=0.05;

for i=3:p-2
    for j=3:q-2
        mat=zeros(2,2);
        for k=1:25
            %structure tensor matrix
            mat(1,1)=mat(1,1)+img_x(i+window_y(k),j+window_x(k))^2;
            mat(2,2)=mat(2,2)+img_y(i+window_y(k),j+window_x(k))^2;
            mat(1,2)=mat(1,2)+img_x(i+window_y(k),j+window_x(k))*img_y(i+window_y(k),j+window_x(k));
        end
        mat(2,1)=mat(1,2);
        %finding eigen values and computing corner response function for
        %each pixel
        lambda=eig(mat);
        r(i-2,j-2)=lambda(1)*lambda(2)-alpha*(lambda(1)+lambda(2))^2;
    end
end
figure()
imshow(img_x)
imwrite(img_x,'que4_hor_gradient.jpg')
figure()
imshow(img_y)
imwrite(img_y,'que4_ver_gradient.jpg')
figure()
imshow(r)
imwrite(r,'que4_corner_response.jpg')

%%
%Thresholding corner response and performing non-maximal suppression
r=padarray(r,[2,2],'both');

res=zeros(size(r)-4);
%threshold value
thresh=10000000;

for i=3:size(r,1)-2
    for j=3:size(r,2)-2
        %if its greater than threshold we perform non-maximal suppression
        %centered in a 5x5 window
        if r(i,j)>thresh
            for k=[1:12 14:25]
                if(r(i,j)>r(i+window_y(k),j+window_x(k)))
                    res(i-2,j-2)=1;
                else
                    res(i-2,j-2)=0;
                    break;
                end
            end
        end
    end
end
figure()
imshow(res)
imwrite(res,'que4_corner_points.png')
%%
res=padarray(res,[2,2],'both');
%superimposing corner points on original image and plotting it
[row,col]=find(res);
rgb=imread('IITG.jpg');
rgb= insertMarker(rgb,[col,row],'x','color','red');
figure()
imshow(rgb)
title('Harris corner detection')
imwrite(rgb,'que4_harris_corner_detection.png')
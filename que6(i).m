%%
clear all;
clc;
%%
%loading input image
img = imread('sunflower.jpg');
img = rgb2gray(img);

[p,q]=size(img);

%computing dct for 8x8 blocks
for i=1:p/8
    for j=1:q/8
        coeffs = dct2(img(8*(i-1)+1:8*i,8*(j-1)+1:8*j));
        %retaining only top 25% co-efficients by magnitude
        coeffs_flatten = reshape(coeffs,[],1);
        [val,ind]=sort(abs(coeffs_flatten),'descend');
        coeffs(ind(17:end))=0;
        %reconstructing image with most important information
        reconstructed_img(8*(i-1)+1:8*i,8*(j-1)+1:8*j)=idct2(coeffs);
    end
end
%plotting figures
figure()
imshow(img);
reconstructed_img=uint8(reconstructed_img);
figure()
imshow(reconstructed_img);
imwrite(reconstructed_img,'recontructed_dct.jpg');
figure()
%diff between reconstructed and original image
%the error image is scaled appropriately for proper visualization
err_img=(int8(reconstructed_img)-int8(img));
imshow(8*err_img)
%euclidean reconstruction error
err=norm(double(reconstructed_img-img))
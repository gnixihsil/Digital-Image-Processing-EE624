%loading input image
img=imread('unifnoisy.jpg');
img=rgb2gray(img);

%diff combination of sigma values for range and domain filtering
[sigma_r,sigma_d]=meshgrid([10 30 100 200],[1 3 10 20]);

for i=1:16
    %calling bilateral filter function for a particular value of sigma
    res=bilateral_filter(img,sigma_d(i),sigma_r(i));
    %plotting figures
    subplot(size(sigma_r,1),size(sigma_r,2),i),imshow(res)
    title(strcat(int2str(sigma_d(i)),',',int2str(sigma_r(i))))
end

suptitle('Bilateral filtering: Domain Variance, Range Varaince')
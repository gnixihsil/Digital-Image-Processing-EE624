function que3

% read image and size of the image
image = imread('lenna.noise.jpg');
figure ; imshow(image)
image = double(image);

% Size of the image
[m,n]=size(image);

% initialize output
output=zeros(m-15,n-15);
% Replicate the boundaries of the input image
% image = padarray(image,[5,5],'symmetric');

% Used kernel
kernel = fspecial('Gaussian',[7,7],2);
kernel = kernel / sum(sum(kernel));

h=25;
h=h*h;
for i=6:501
    for j=6:501
        % extracted patch
        W1= image(i:i+6 , j:j+6);
        
        % initializations
        wmax=0; average=0;  sweight=0;
        
        % row and column limits for operations
        rmin = i-2;  rmax = i+2;
        smin = j-2;  smax = j+2;
        
         for r=rmin:1:rmax
             for s=smin:1:smax
                 % W2 patch in neighbourhood
                 W2= image(r-3:r+3,s-3:s+3);                
                 d = sum(sum(kernel.*(W1-W2).*(W1-W2)));
                 
                 % weight of pixel
                 w=exp(-d/h);                                                  
                 if w>wmax                
                     wmax=w;                   
                 end
                sweight = sweight + w;
                average = average + w*image(r,s);                                  
             end 
         end
         average = average + wmax*image(i,j);
         sweight = sweight + wmax;
         if sweight > 0
             output(i-5,j-5) = average / sweight;
         else
             output(i-5,j-5) = image(i,j);
         end                
    end
end
 figure; imshow(output/255)
end
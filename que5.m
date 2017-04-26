function Pseudoinversefiltering

% read images
a = imread('degraded.tif');

% generating fft and centering fft 
ff = fftshift(fft2(double(a)));

% intializing inverse filter and generating filter
h=double(zeros(480,480));
h1=h;
for i =1:480
    for j=1:480
        h(i,j)=exp(0.0025*power(((i-240)*(i-240)+(j-240)*(j-240)),5/6));
        %h(i,j)=exp(0.0025*power(((i)*(i)+(j)*(j)),5/6));
         if(h(i,j)>200)
            h1(i,j)=200;
        else
            h1(i,j)=h(i,j);
        end
    end
end

% normalizing filter
nh1=h1/200;

% multiplying filter response in frequency domain
f=ff.*nh1;

% conversion back to image
c=real(ifft2(ifftshift(f)));
c=c/max(max(c));
imshow(c)

% smoothing a little
h = ones(4,4) / 16;
imshow(imfilter(c,h))

end
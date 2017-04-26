function [ res ] = bilateral_filter( img,sigma_d,sigma_r )

%prewitt filter of size 5x5 for horizontal and vertical gradients
window_y=repmat(-2:2,5,1);
window_x=repmat((-2:2)',1,5);

%intiliazing result image
res=zeros(size(img));

%converting input image to appropriate form by padding and typecasting
img=padarray(img,[2,2],'both');
img=cast(img,'double');

%convolving the 5x5 filter across the whole image
for i=3:(size(img,1)-2)
    for j=3:(size(img,2)-2)
        %at one particular position of a filter
        norm=0;
        for k=1:25
            %range and domain filtering respectively
            weight=exp(-((img(i+window_y(k),j+window_x(k))-img(i,j))/(1.414*sigma_r))^2)*exp(-((window_x(k)^2+window_y(k)^2)/(2*sigma_d^2)));
            res(i-2,j-2)=res(i-2,j-2)+weight*img(i+window_y(k),j+window_x(k));
            norm=norm+weight;
        end
        res(i-2,j-2)=res(i-2,j-2)/norm;
    end
end

%converting result into a 8 bit image
res=cast(res,'uint8');
end


function anisotropicdiffusion(n, delta, kappa, type)

% given image
image = imread('lenna.noise.jpg');
figure ; imshow(image)

% conversion to double
image = double(image);

% initializations
out_image = image;
dx = 1;
dy = 1;
dd = sqrt(2);

% 2D convolution masks - finite differences.
hNorth = [0 1 0; 0 -1 0; 0 0 0];
hSouth = [0 0 0; 0 -1 0; 0 1 0];
hEast = [0 0 0; 0 -1 1; 0 0 0];
hWest = [0 0 0; 1 -1 0; 0 0 0];
hNorthEast = [0 0 1; 0 -1 0; 0 0 0];
hSouthEast = [0 0 0; 0 -1 0; 0 0 1];
hSouthWest = [0 0 0; 0 -1 0; 1 0 0];
hNorthWest = [1 0 0; 0 -1 0; 0 0 0];

% Anisotropic diffusion.
for i = 1:n
        nablaNorth = imfilter(out_image,hNorth,'conv');
        nablaSouth = imfilter(out_image,hSouth,'conv');   
        nablaWest = imfilter(out_image,hWest,'conv');
        nablaEast = imfilter(out_image,hEast,'conv');   
        nablaNorthEast = imfilter(out_image,hNorthEast,'conv');
        nablaSouthEast = imfilter(out_image,hSouthEast,'conv');   
        nablaSouthWest = imfilter(out_image,hSouthWest,'conv');
        nablaNorthWest = imfilter(out_image,hNorthWest,'conv'); 
       
        if type == 1
            cNorth = exp(-(nablaNorth/kappa).^2);
            cSouth = exp(-(nablaSouth/kappa).^2);
            cWest = exp(-(nablaWest/kappa).^2);
            cEast = exp(-(nablaEast/kappa).^2);
            cNorthEast = exp(-(nablaNorthEast/kappa).^2);
            cSouthEast = exp(-(nablaSouthEast/kappa).^2);
            cSouthWest = exp(-(nablaSouthWest/kappa).^2);
            cNorthWest = exp(-(nablaNorthWest/kappa).^2);
        elseif type == 2
            cNorth = 1./(1 + (nablaNorth/kappa).^2);
            cSouth = 1./(1 + (nablaSouth/kappa).^2);
            cWest = 1./(1 + (nablaWest/kappa).^2);
            cEast = 1./(1 + (nablaEast/kappa).^2);
            cNorthEast = 1./(1 + (nablaNorthEast/kappa).^2);
            cSouthEast = 1./(1 + (nablaSouthEast/kappa).^2);
            cSouthWest = 1./(1 + (nablaSouthWest/kappa).^2);
            cNorthWest = 1./(1 + (nablaNorthWest/kappa).^2);
        end
        % Discrete PDE solution.
        out_image = out_image + ...
                  delta*(...
                  (1/(dy^2))*cNorth.*nablaNorth + (1/(dy^2))*cSouth.*nablaSouth + ...
                  (1/(dx^2))*cWest.*nablaWest + (1/(dx^2))*cEast.*nablaEast + ...
                  (1/(dd^2))*cNorthEast.*nablaNorthEast + (1/(dd^2))*cSouthEast.*nablaSouthEast + ...
                  (1/(dd^2))*cSouthWest.*nablaSouthWest + (1/(dd^2))*cNorthWest.*nablaNorthWest );
        fprintf('\rIteration %d\n',i);
figure ; imshow(out_image,[])
end
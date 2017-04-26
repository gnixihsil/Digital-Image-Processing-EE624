# Digital-Image-Processing-EE624

The input images can be found in EE_624_2016_assignment.rar

# 1. Histogram Specification
Modify the histogram of the image givenhist.jpg in such a way that the resulting his-
togram nearly approximates the histogram of the image sphist.jpg. Display the his-
togram of the image givenhist.jpg after this transformation.

# 2. Bilateral Filter
In this experiment, we will study the performance of the filters in de-noising images.
You are given 3 images - spnoisy.jpg, unifnoisy.jpg and spunifnoisy.jpg. These are
photographs corrupted with different types of noise. Try to reduce the effect of noise from
each of them by applying a bilateral filter with mask size 5 × 5 with appropriate values
of σ d 2 and σ r 2 , set through experimentation.

# 3. Edge preserving smoothing filters
You are provided with a noisy picture of Lenna. (Lenna noise.jpg). In this task, you
are expected to explore a set of edge preserving filters, to address the problem of image
denoising. For each filter, display both the input and de-noised image.
(i) Anisotropic non-linear diffusion filter: Implement the anisotropic diffusion
filter for reducing the effect of noise. Consider adapting the value of the conduction
coefficient, so as to stop the diffusion on the edges. Nevertheless, to get a visually
pleasing result, it is suggested to iterate through the algorithm several times. You
may consider either a 4 or 8 neighbour connectivity.
1(ii) Non-local means filter: Denoise the image using the non-local means filter. For
faster implementation, restrict the search of similar patches in a window of size 5×5
pixels around the current patch. In addition, assume each patch to be of size 7×7.
To get better results, it is expected that you compute the Gaussian weighted Sum
of Squares distance between the patches. The bandwidth / scale of the Gaussian
may set experimentally.

# 4. Corner Detection
Implement the Harris corner detector algorithm on the image IITG.jpg. Superimpose
the corner points on to the relevant pixels in the image. It is suggested that you choose a
suitable threshold to pick up the interest points, followed by a non-maximal suppression
step.

# 5.Image Restoration
The aerial image degraded.tif has been degraded with atmospheric turbulence. The
goal is to restore this image using the Pseudo inverse filter . Display the restored image.

# 6. Unitary Transforms
(i) Divide the image sunflower.jpg to 8×8 blocks. Compute the DCT for each block.
Retain the top 25% of highest DCT coefficients (highest with respect to magnitude)
in each block and set the other coefficients to zero. Take the inverse DCT for
each of the blocks and subsequently display the reconstructed image. Compute the
reconstruction error.
(ii) Perform a one level wavelet decomposition on the 512×512 image lena.jpg.

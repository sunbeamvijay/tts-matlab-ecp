display(clock)

im_name='lena.bmp';
N_neighborhood=8;
threshold=2;

I=imread(im_name);
figure
imshow(I)
title('Original Image')

I_noise=imnoise(I,'salt & pepper',0.02);
figure
imshow(I_noise)
title('Image with impulse noise')

I_denoise=extrema_killer(I_noise,threshold,N_neighborhood);
figure
imshow(I_denoise)
title('Image after denoising')

display(clock)
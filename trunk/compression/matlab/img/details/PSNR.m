function psnr=PSNR(im1, im2)

[M,N]=size(im1);

diff=double(im1)-double(im2);

if max(im1)<=1
    diff=diff*255;
end

eqm=sum(sum(diff.^2))/(M*N);

psnr=10*log(255^2/eqm)/log(10);
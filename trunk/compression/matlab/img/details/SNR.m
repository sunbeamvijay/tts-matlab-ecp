function psnr=SNR(im_original, im_noise)

diff=double(im_original)-double(im_noise);

ps=sum(sum(double(im_original).^2));

pn=sum(sum(diff.^2));

psnr=10*log(ps/pn)/log(10);
clc;clear all;
a1=imread("q1.jpg");% load image to workspace 
a2=fft2(a1); % 2d fast fourier transform
a2_shift=fftshift(a2,3);%  it brings dc point to the center and in image dc point are purely white
[m,n,c]=size(a1);% get size of matrix related to image
figure(1)
%% plot
subplot(4,2,2)
imshow(a1)
title('Original');
subplot(4,2,1)
imshow(uint8(abs(a2_shift)));
title('q1-res1');

%%  ideal filter (it has ringing)
h=ones(m,n);
k=5;
   h(1:500,1:500)=0; % we set frequencies below 500 to 0
   h_f=fftshift(h);
   new_a=ifft2(((1+ k.*h_f).*a2_shift));%% we add it by 1 not to get zero
new_a_shift=ifftshift((new_a),3);
%plot
subplot(4,2,3)
mesh(h);
title('mesh show')
subplot(4,2,4)
imshow(uint8(new_a_shift));
title('sharpened with ideal filter in the book')
%%  buterworth filter(it does not have ringing)
cut_off=1;%our cut_off frequency of sigma in gaussian distribution
order=0.5; % our butterworth order
d=zeros(m,n);
h=zeros(m,n);
    for i=1:m
    for j=1:n
   
        d(i,j)=sqrt(((i-(m/2))^2)+((j-(n/2))^2));
 h(i,j)=1/((1+(cut_off/d(i,j)))^(2*order));
    end
    end
h=fftshift(h);
    HPF_image_bw=a2_shift.*fftshift(h);
    HPF_image_bw_inverse=ifftshift(abs(ifft2(HPF_image_bw)),3);
   HPF_image_bw_inverse_real=abs( HPF_image_bw_inverse);   
   % plot
subplot(4,2,5)
 mesh(h);
title('mesh show')
subplot(4,2,6)
imshow(uint8(HPF_image_bw_inverse_real));
title('sharpened with Butterworth')

   %% Gaussian filter(it does not have ringing)
for i=1:m
    for j=1:n
      d(i,j)=sqrt(((i-(m/2))^2)+((j-(n/2))^2));
 h(i,j)=1-exp(-(d(1,j)^2)/(2*cut_off.^2));
    end
end
    HPF_image_gaussian=a2_shift.*fftshift(h);
    HPF_image_gaussian_inverse=ifftshift(abs(ifft2(HPF_image_gaussian)),3);
   HPF_image_gaussian_inverse_real=abs(HPF_image_gaussian_inverse);   
subplot(4,2,7)
mesh(h)
subplot(4,2,8)
imshow(uint8(HPF_image_gaussian_inverse_real));
title('sharpened with Gaussian')
%% writing images
imwrite(uint8(abs(new_a_shift)),'q1-res2.jpg');
imwrite(uint8(abs(a2_shift)),'q1-res1.jpg');


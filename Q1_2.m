clc;clear all;
f=imread("q1.jpg");
f2=fft2(f);
F=fftshift(f2,3);% it brings dc point to the center and in image dc point are purely white
[m,n,c]=size(f);%get size of matrix related to image 
[u,v] = meshgrid(-m/2:m/2-1,-n/2:n/2-1);
k=1e-6;
H_equivalent=4*(pi^2).*(u.^2 + v.^2);
H_equivalent=fftshift(H_equivalent);
 h=uint8(abs(k*ifft2(H_equivalent.*F)));
 new_a=f+h;
  new_a_shift=ifftshift((new_a),3);
  % BAD STATE
  k=1e-5;
H_equivalent=4*(pi^2).*(u.^2 + v.^2);
H_equivalent=fftshift(H_equivalent);
 h=uint8(abs(k*ifft2(H_equivalent.*F)));
new_a_bad=f+h;
  new_a_bad_shift=ifftshift((new_a_bad),3); 
  %% plot
  figure(1)
  subplot(1,3,2)
 imshow((new_a));
 title('sharpend by k=1e-6')
  subplot(1,3,1)
 imshow((f));
 title('Original')
  subplot(1,3,3)
 imshow((new_a_bad));
 title('sharpend by k=1e-5')
%% writing images
imwrite((new_a),'q1-res3.jpg');

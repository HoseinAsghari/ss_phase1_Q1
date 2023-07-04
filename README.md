# ss_phase1_q1
As you know high pass filter boosts high frequencies and weaken low frequencies . this  property cause sharpening in our picture\\
in relation of $F^{-1}(1+kH_{HP})F$ we can boost HPF  by constant of k to sharpen our image more 
\\some explanations about code:
\\ we use three types of fliters . named as Butterworth , Gaussian and ideal filter whic is brought in the book. considerable point was that in the Gaussian filter we see less ringing than ideal filters (because ideal filters have discontinuity) .\\
by iterative method we tested that k=5 for ideal filter is appropriate and for Butterworth order=0.5 and cut-off=1 and in the Gaussian filter the only parameter is standard deviation that is equal to cut-off
function [F, F2] = imgFourier(img, Rows, Cols) 
  figure;
  imshow (img);
  F = fft2(img, Rows, Cols);
  F2 = fftshift(F);
  figure;  
  imshow(log(abs(F2)), []);
  colormap(jet);
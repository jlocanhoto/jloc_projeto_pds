function img8bpp = NormalizeImage(imgDouble)
  minImgDouble =  min(imgDouble(:));
  factor = (255-0)/(max(imgDouble(:)) - minImgDouble);
  img8bpp = uint8((imgDouble-minImgDouble).*factor);
end
function [lostFrame] = recoverFrame(frameBefore, frameAfter, blur)
  meanFrame     = (frameBefore + frameAfter)/2;
  
  if (blur > 0)
    fSize         = 5; % filter size (ex: 9 = 9x9)
    fGauss        = fspecial("gaussian", fSize, blur);
    meanFramePad  = padarray(meanFrame, [floor(fSize/2) floor(fSize/2)], "symmetric");
    meanFrame     = filter2(fGauss, meanFramePad, "valid");
  endif;
  
  lostFrame     = frameBefore + meanFrame;
end;
function contrastYCbCr(img)
  global newYCbCr;
  global originalY;
  global Ymean;
  global imageHandle;  
  
  YCbCr = newYCbCr = rgb2ycbcr(img);
  [rows cols color] = size(img);

  originalY  = YCbCr(:,:,1);
  originalCb = YCbCr(:,:,2);
  originalCr = YCbCr(:,:,3);
  
  Ymean = mean2(originalY);
  Cbmean = mean2(originalCb);
  Crmean = mean2(originalCr);
  
  percentY = 0.6;
  percentX = percentY*cols/rows;
  f = figure ('name', 'YCbCr Contrast', 'pos', [100 100 500 500]);
  axes ('position', [(1-percentX)/2, 0.35, percentX, percentY]);
  axis ([0, cols, 0, rows]);  
  imageHandle = image(img, 'XData', [0 cols], 'YData', [0 rows]);
  axis off;
  
  sldFactor = uicontrol (          ...
   'style', 'slider',             ...
   'Units', 'pixels',             ...
   'min', -5,                     ...
   'max', +5,                     ...
   'value', 0,                    ...
   'position', [50, 75, 400, 25], ...
   'callback', {@contrastFactor}  ...
  );
  
  txtFactor = uicontrol (                    ...
   'style', 'edit',                ...
   'string', '0', ...
   'Units', 'pixels',            ...
   'value', 123456, ...
   'position', [50, 30, 100, 25], ...
   'callback', {@contrastFactor}          ...
  );
end

function contrastFactor(src, event)
  global newYCbCr;
  global Ymean;
  global originalY;
  global imageHandle;
  
  if (strcmp(get(src, 'style'), 'edit'))
    crstFactor = str2num(get(src, 'string'));
  else
    crstFactor = get(src, 'value');
  end
  
  newYCbCr(:,:,1) = originalY + crstFactor * Ymean;
  
  set(imageHandle ,'CData', ycbcr2rgb(newYCbCr));
  
  disp(num2str(crstFactor));
end
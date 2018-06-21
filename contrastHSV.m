function contrastHSV(img)
  global newHSV;
  global originalS;
  global originalV;
  global Vmean;
  global Smean;
  global imageHandle;
  global sldFactorS;
  global txtFactorS;
  global sldFactorV;
  global txtFactorV;
  
  hsv = newHSV = rgb2hsv(img);
  [rows cols color] = size(img);

  originalS = hsv(:,:,2);
  originalV = hsv(:,:,3);
  
  Vmean = mean2(originalV);
  Smean = mean2(originalS);
  
  percentY = 0.6;
  percentX = percentY*cols/rows;
  f = figure ('name', 'HSV Contrast', 'pos', [100 100 500 500]);
  axes ('position', [(1-percentX)/2, 0.35, percentX, percentY]);
  axis ([0, cols, 0, rows]);  
  imageHandle = image(img, 'XData', [0 cols], 'YData', [0 rows]);
  axis off;
  
  sldFactorS = uicontrol (          ...
   'style', 'slider',             ...
   'Units', 'pixels',             ...
   'min', -5,                     ...
   'max', +5,                     ...
   'value', 1,                    ...
   'position', [50, 75, 300, 25], ...
   'callback', {@contrastFactorS}  ...
  );
  
  txtFactorS = uicontrol (                    ...
   'style', 'edit',                ...
   'string', '1', ...
   'Units', 'pixels',            ...
   'value', 123456, ...
   'position', [360, 75, 100, 25], ...
   'callback', {@contrastFactorS}          ...
  );

  sldFactorV = uicontrol (          ...
   'style', 'slider',             ...
   'Units', 'pixels',             ...
   'min', -5,                     ...
   'max', +5,                     ...
   'value', 1,                    ...
   'position', [50, 25, 300, 25], ...
   'callback', {@contrastFactorV}  ...
  );
  
  txtFactorV = uicontrol (                    ...
   'style', 'edit',                ...
   'string', '1', ...
   'Units', 'pixels',            ...
   'value', 123456, ...
   'position', [360, 25, 100, 25], ...
   'callback', {@contrastFactorV}          ...
  );
end

function contrastFactorS(src, event)
  global newHSV;
  global Vmean;
  global Smean;
  global originalV;
  global originalS;
  global imageHandle;
  global sldFactorS;
  global txtFactorS;
  
  % text
  if (strcmp(get(src, 'style'), 'edit'))
    crstFactor = str2num(get(src, 'string'));
    set(sldFactorS, 'value', crstFactor);
  % sliding bar
  else
    crstFactor = get(src, 'value');
    set(txtFactorS, 'string', num2str(crstFactor));
  end
  
  newHSV(:,:,2) = crstFactor * originalS;
  
  set(imageHandle ,'CData', hsv2rgb(newHSV));
  
  %disp(num2str(crstFactor));
end

function contrastFactorV(src, event)
  global newHSV;
  global Vmean;
  global Smean;
  global originalV;
  global originalS;
  global imageHandle;
  global sldFactorV;
  global txtFactorV;
  
  % text
  if (strcmp(get(src, 'style'), 'edit'))
    crstFactor = str2num(get(src, 'string'));
    set(sldFactorV, 'value', crstFactor);
  % sliding bar
  else
    crstFactor = get(src, 'value');
    set(txtFactorV, 'string', num2str(crstFactor));
  end
  
  newHSV(:,:,3) = Vmean + crstFactor * (originalV - Vmean);
  
  set(imageHandle ,'CData', hsv2rgb(newHSV));
  
  %disp(num2str(crstFactor));
end

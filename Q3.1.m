clear; clc; close all;

% If running on Octave, uncomment line bellow
pkg load image;
pkg load video;

% PARÂMETROS DO ARQUIVO DE IMAGEM
relativeFilesFolder = './arquivos/frames/';

delete([relativeFilesFolder 'saida_102.bmp']);
delete([relativeFilesFolder 'saida_110.bmp']);
delete([relativeFilesFolder 'saida_118.bmp']);

fileList = dir([relativeFilesFolder '*.bmp']);

indexes = [2 9 16];
avi = avifile('recovered.avi');

origFramesFolder = './arquivos/frames_perdidos/';

origFrames = {};
origFrames(1,:) = imread([origFramesFolder 'saida_102_2.bmp']);
origFrames(2,:) = imread([origFramesFolder 'saida_110_2.bmp']);
origFrames(3,:) = imread([origFramesFolder 'saida_118_2.bmp']);


for j=1:length(indexes)
  i = indexes(j);
  
  frameBefore = imread([relativeFilesFolder fileList(i).name]);
  frameAfter  = imread([relativeFilesFolder fileList(i+1).name]);
  lostFrame   = recoverFrame(double(frameBefore), double(frameAfter), 0);
  lostFrame   = NormalizeImage(lostFrame);
  
  errBefore     = immse(lostFrame, frameBefore);
  errAfter      = immse(lostFrame, frameAfter);
  errCorrect    = immse(lostFrame, origFrames{j});
  
  disp(j);
  fprintf('MSE Before and Lost = %.4f\n', errBefore);
  fprintf('MSE After and Lost = %.4f\n', errAfter);
  fprintf('MSE Correct and Lost = %.4f\n\n', errCorrect);
  
  figure;imshow(lostFrame);

  iBefore = str2num(strsplit(strsplit(fileList(i).name, '_'){2}, '.'){1});
  lostFrameName = [relativeFilesFolder 'saida_' num2str(iBefore+1) '.bmp'];
  imwrite(lostFrame, lostFrameName);
end;

fileList = dir([relativeFilesFolder '*.bmp']);

for i=1:length(fileList)
  frame = imread([relativeFilesFolder fileList(i).name]);
  frame = double(frame);
  frame = frame/max(max(frame));
  addframe(avi, frame);
end;
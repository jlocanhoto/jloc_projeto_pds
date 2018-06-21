clear; clc; close all;

% PARÂMETROS DO ARQUIVO DE IMAGEM
relativeFilesFolder = './arquivos/';
imgFileName = 'alumgrns.bmp';
imgFile = [relativeFilesFolder imgFileName];
img = imread(imgFile);

% PARÂMETROS DO ALGORITMO DE DETECÇÃO DE BORDAS DE CANNY
sigma = 1;
threshold = 0.05;

bw = edge(img, 'Canny', threshold, sigma);

[rows cols] = size(bw);

SE = strel('square', 5);
bw = imdilate(bw, SE);
SE = strel('square', 3);
bw = imerode(bw, SE);
figure;
imshow(bw);

bw(1,:) = 1;
bw(rows,:) = 1;
bw(:,1) = 1;
bw(:,cols) = 1;

[labeledImage, numBlobs] = bwlabel(bw);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
figure;
imshow(coloredLabels);

% menos 1 por conta da textura das demarcações principais de fronteira
qtdTexturas = numBlobs-1;
%disp(['No. Texturas = ' int2str(numBlobs-1)]);

%mainBorder = _labeledImage(1,1);

%for i=1:rows
%  for j=1:cols
%    if (_labeledImage(i,j) == mainBorder)
%      _labeledImage(i,j) = 1;
%        
%  end
%end

bw = 1 - bw;

[labeledImage, numBlobs] = bwlabel(bw);
coloredLabels = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
figure;
imshow(coloredLabels);

%disp(['No. Texturas = ' int2str(numBlobs)]);
qtdTexturas += numBlobs;

disp(['No. Texturas = ' int2str(qtdTexturas)]);

% img = medfilt2(img, [3 3]);
% bw = edge(img, 'Sobel', 0.01, 'nothinning');
% figure;
% imshow(bw);

% SE = strel('disk', 1, 0);
% bw = imclose(bw, SE);
% figure;
% imshow(bw);
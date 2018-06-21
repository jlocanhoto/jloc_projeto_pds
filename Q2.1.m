clear; clc; close all;

% PARÂMETROS DO ARQUIVO DE IMAGEM
relativeFilesFolder = './arquivos/';
imgFileName = 'lena_rings.bmp';
imgFile = [relativeFilesFolder imgFileName];

% PARÂMETROS DO FILTRO DE BUTTERWORTH
n = 4;
wc0 = 90;
wc1 = 100;

img = imread(imgFile);
[rows cols] = size(img);
Rows = rows*2; Cols = cols*2;

[F, F2] = imgFourier(img, Rows, Cols);

[butterBPF] = butterworthBandPassFilter(n, wc0, wc1, rows, cols);
% Foi necessário multiplicar por um fator de 3 para aumentar a intensidade do filtro,
% pois com um fator de 1 a filtragem era quase imperceptível e os rings ainda predominavam
filteredImgF = F2 - (3).* F2.*butterBPF;

figure;
imshow(log(abs(filteredImgF)), []);
colormap(jet);

filteredImg = ifftshift(filteredImgF);
filteredImg = ifft2(filteredImg, Rows, Cols);
filteredImg = real(filteredImg(1:rows, 1:cols));
filteredImg = uint8(filteredImg);

figure;
imshow(filteredImg);
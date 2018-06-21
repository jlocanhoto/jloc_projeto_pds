clear; clc; close all;

% If running on Octave, uncomment line bellow
pkg load image;

% PARÂMETROS DO ARQUIVO DE IMAGEM
relativeFilesFolder = './arquivos/';
imgFileName = 'dalton.bmp';
imgFile = [relativeFilesFolder imgFileName];
img = imread(imgFile);

contrastHSV(img);
%contrastYCbCr(img);
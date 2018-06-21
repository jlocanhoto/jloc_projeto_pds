%clear; clc; close all;

% If running on Octave, uncomment line bellow
pkg load signal;

% PARÂMETROS DO ARQUIVO DE IMAGEM
relativeFilesFolder = './arquivos/';
audioFileName = 'sp04.wav';
audioFile = [relativeFilesFolder audioFileName];
[x, Fs] = audioread(audioFile);

D = 500;
delayedX = vertcat(zeros(D,1), x(1:end-D));

x2 = x + delayedX;

coefs_a = [0.25 0.5 0.9];
%coefs_a *= -1;
coef_a = coefs_a(3);

% Filter function: y = filter(b,a,x)
b = [1]; % numerador
a = zeros([1 D]); % denominador - cria um vetor de 1 a D com coeficientes iguais a zero
a(1) = 1;
a(D) = coef_a;
y = filter(b, a, x2);
sound(y);

%{
figure;
for i=1:length(coefs_a)
  coef_a = coefs_a(i);
  a(D) = coef_a;
  y = filter(b, a, x2);
  subplot(3,2,i*2-1);
  plot(y);
  title(["Sinal y com a = " num2str(coef_a)]);
  subplot(3,2,i*2);
  stem(abs(fftshift(fft(y))));
  title(["FFT de Y com a = " num2str(coef_a)]);
end;
%}
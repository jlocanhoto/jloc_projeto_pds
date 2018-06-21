%https://en.wikipedia.org/wiki/Audio_time_stretching_and_pitch_scaling
clear; clc; close all;

% If running on Octave, uncomment line bellow
pkg load signal;

% PARÂMETROS DO ARQUIVO DE IMAGEM
relativeFilesFolder = './arquivos/';
audioFileName = 'dg105.wav';
audioFile = [relativeFilesFolder audioFileName];
[y, Fs] = audioread(audioFile);

plotAudioSpectogram(y, Fs);

y = moveAdjacentSignal(y, 17100, 19570, 28000);
y = moveAdjacentSignal(y, 53800, 55930, length(y));

plotAudioSpectogram(y, Fs);

sound(y);

%{
Reamostragem foi feita para tentar esticar porção do sinal. Esse método acaba mudando o
tom da voz. Para se fazer esse alongamento do audio sem alterar a voz da pessoa,
é necessário implementar um phase vocoder.
%}
x = y;
_aud = x(17000:20000);
audio = resample(_aud,8,5);
x(17000:17000+length(audio)-1) = audio;

subplot(2,1,1);
plot(y);
subplot(2,1,2);
plot(x);
sound(x);
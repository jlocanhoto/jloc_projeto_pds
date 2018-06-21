clear; clc; close all;

% If running on Octave, uncomment line bellow
pkg load signal;

% PARÂMETROS DO ARQUIVO DE IMAGEM
relativeFilesFolder = './arquivos/';
audioFileName = 'teste_de_som.wav';
audioFile = [relativeFilesFolder audioFileName];
[orig, Fs] = audioread(audioFile);

f = 466.16; % sinusodial noise frequency in Hz
w = 2*pi*f; % sinusodial noise frequency in rad/s
period = 1/Fs;
t = [0 : period : (size(orig)(1)-1)*period];
sinusodialNoise = sin(w*t);

y = orig * 30;
y = y + sinusodialNoise'; % y é o sinal final com as modificações

figure(1);
subplot(3,1,1);
plot(orig);
title("Sinal Original");
subplot(3,1,2);
plot(y);
title("Sinal com ruído");

%{
step = fix(5*Fs/1000);     # one spectral slice every 5 ms
window = fix(40*Fs/1000);  # 40 ms data window
fftn = 2^nextpow2(window); # next highest power of 2

[S1, f1, t1] = specgram(y, fftn, Fs, window, window-step);
figure(3);
imagesc(flipud(20*log10(abs(S1(2:fftn*4000/Fs,:)))));
colormap(jet);

[S, f, t] = specgram(orig, fftn, Fs, window, window-step);
figure(4);
imagesc(flipud(20*log10(abs(S(2:fftn*4000/Fs,:)))));
colormap(jet);
%}

Y = fft(y, 256);
freq = linspace(-0.5,0.5,256);
N = size(y)(1);
magY = abs(Y);
spec = 20*log10(magY);        % magnitude in dB
spec = spec - max(spec);      % Normaliza a maginitude

n = 60;
b = fir1(n, [0.04 0.35], 'stop', hamming(n+1));
%b = fir1(n, [0.04 0.35], 'stop', hanning(n+1));
%b = fir1(n, [0.04 0.35], 'stop', gausswin(n+1));
%b = fir1(n, [0.04 0.35], 'stop', blackman(n+1));
%b = fir1(n, [0.04 0.35], 'stop', kaiser(n+1, 2.5));
filtered = filter(b, 1, y);
magFiltered = abs(fft(filtered,256));

figure(2);
subplot(1,3,1);
plot(freq, abs(fftshift(fft(orig, 256))));
title("FFT do sinal original");
subplot(1,3,2);
plot(freq, fftshift(magY));
title("FFT do sinal com ruído");
subplot(1,3,3);
plot(freq, fftshift(magFiltered));
title("FFT do sinal filtrado");

filtered = filtered/3; % adjusting the volume a little bit
figure(1);
subplot(3,1,3);
plot(filtered);
title("Sinal filtrado");
sound(filtered);

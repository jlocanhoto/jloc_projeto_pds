clear; clc; close all;

% If running on Octave, uncomment line bellow
pkg load signal;

dt = 0.01;
fs = 1/dt;

n = 0:dt:10; % (n de zero a 10 de 0.01 em 0.01)
y = sin(20 * pi * n) + cos(30 * pi * n); % y é um vetor
z = sin(40 * pi * n) + cos(60 * pi * n); % z é um vetor
w = [y z];

[Y, phsY] = DFT(y, fs); % item a
[Z, phsZ] = DFT(z, fs); % item b
[W, phsW] = DFT(w, fs); % item c

Nw = length(w);
nsc = floor(Nw/4.5);
nov = floor(nsc/1);
fftn = max(256, 2^nextpow2(nsc));

[S, f, t] = specgram(w);
figure;
imagesc(t, f, flipud(20*log10(abs(S))));
%imagesc(flipud(20*log10(abs(S))));
colormap(parula);

% Multiplot
%{
lenF = length(Y);
freqAxis = (-lenF/2:lenF/2-1)*fs/lenF;
lenW = length(W);
freqAxisW = (-lenW/2:lenW/2-1)*fs/lenW;

figure;
subplot(3,2,1);
stem(freqAxis, fftshift(abs(Y)));
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
title('FFT Y [Magnitude]');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
grid on;

subplot(3,2,3);
stem(freqAxis, fftshift(abs(Z)));
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
title('FFT Z [Magnitude]');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
grid on;

subplot(3,2,5);
stem(freqAxisW, fftshift(abs(W)));
set(gca,'xtick',[min(freqAxisW)-10 : 10 : max(freqAxisW)+10]);
title('FFT W [Magnitude]');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
set(gca,'xtick',[min(freqAxisW)-10 : 10 : max(freqAxisW)+10]);
grid on;

subplot(3,2,2);
plot(freqAxis, fftshift(phsY));
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
title('FFT Y [Fase]');
xlabel('Frequência (Hz)');
ylabel('Fase (rad)');
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
grid on;

subplot(3,2,4);
plot(freqAxis, fftshift(phsZ));
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
title('FFT Z [Fase]');
xlabel('Frequência (Hz)');
ylabel('Fase (rad)');
set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
grid on;

subplot(3,2,6);
plot(freqAxisW, fftshift(phsW));
set(gca,'xtick',[min(freqAxisW)-10 : 10 : max(freqAxisW)+10]);
title('FFT W [Fase]');
xlabel('Frequência (Hz)');
ylabel('Fase (rad)');
set(gca,'xtick',[min(freqAxisW)-10 : 10 : max(freqAxisW)+10]);
grid on;
%}
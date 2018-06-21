function plotAudioSpectogram(audio, Fs)
  figure;
  subplot(2,1,1);
  plot(audio);
  axis([0 length(audio) min(audio)*1.2 max(audio)*1.2])

  step = fix(5*Fs/1000);     # one spectral slice every 5 ms
  window = fix(40*Fs/1000);  # 40 ms data window
  fftn = 2^nextpow2(window); # next highest power of 2

  % MATLAB:
  %[S, F, T, P] = spectrogram(y, window, noverlap, nfft, fs, 'yaxis');
  
  % Octave
  [S, f, t] = specgram(audio, fftn, Fs, window, window-step);

  subplot(2,1,2);
  imagesc(flipud(20*log10(abs(S(2:fftn*4000/Fs,:)))));
  colormap(jet);
end;
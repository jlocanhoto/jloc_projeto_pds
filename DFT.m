function [F, phs] = DFT(signal, fs)
  F = fft(signal);
  F2 = fftshift(F);
  phs = unwrap(angle(F));
  phs2 = fftshift(phs);
  
  lenF = length(F);
  freqAxis = (-lenF/2:lenF/2-1)*fs/lenF;
  %{
  figure;
  
  subplot(2,1,1);
  stem(freqAxis, abs(F2));
  xlabel('Frequência (Hz)');
  ylabel('Magnitude');
  set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
  grid on;
  
  subplot(2,1,2);
  plot(freqAxis, phs2);
  xlabel('Frequência (Hz)');
  ylabel('Fase (rad)');
  set(gca,'xtick',[min(freqAxis)-10 : 10 : max(freqAxis)+10]);
  grid on;
  %}
end;
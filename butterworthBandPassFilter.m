function [BPF] = butterworthBandPassFilter(n, w0, w1, rows, cols)
  Rows = rows*2; Cols = cols*2;
  LPF_0 = zeros(Rows, Cols);
  HPF_1 = zeros(Rows, Cols);
  BPF   = zeros(Rows, Cols);
  
  for i = 1:Rows
    
    for j = 1:Cols
      % A fórmula da distância é D(u,v) = √(u² + v²), porém vamos elevar ao
      % quadrado essa distância na fórmula do filtro de Butterworth, então
      % eliminamos computações desnecessárias para tornar o código mais eficiente
      
      D2 = (i - rows)^2 + (j - cols)^2; % distancia ao quadrado
      
      LPF_0(i,j) = 1 / (1 + (D2/(w0^2))^n);       % Low Pass Filter with cut-off frequency w0
      HPF_1(i,j) = 1 - (1 / (1 + (D2/(w1^2))^n)); % High Pass Filter with cut-off frequency w1

      BPF(i,j) = LPF_0(i,j) .* HPF_1(i,j);
      
    end
    
  end

  figure;
  imshow(BPF, []);
  colormap(jet);
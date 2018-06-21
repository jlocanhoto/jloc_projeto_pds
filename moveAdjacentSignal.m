function [y] = moveAdjacentSignal(y, p1, p2, p3)
  gap0 = p1; gap1 = p2;
  deltaGap = gap1 - gap0;
  fill0 = gap1+1; fill1 = p3;
  deltaFill = fill1 - fill0;
  endCut = gap0 + deltaFill;

  y_gap = y(gap0:gap1);
  y_move = y(fill0:fill1);
  y(gap0:endCut) = y_move;
  y(endCut:endCut+deltaGap) = y_gap;
end;
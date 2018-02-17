function dYdt = f_air(Y, t)
  
  global c_f;
  global gamma;
  global d; 
 
  % ��������� ���������� �������
  g = 0.81;
  
  % ��������� �������
  rho = 1.29;
  
  % ����������� ������������� �������
  k = 3 * c_f * rho / 2 / gamma / d;
 
  % ������ �������� �������
  v = sqrt(Y(3) * Y(3) + Y(4) * Y(4));  
  
  % ������� ��������� ��������
  dYdt(1) = Y(3);
  dYdt(2) = Y(4);
  dYdt(3) = - k * v * Y(3);
  dYdt(4) = - k * v* Y(4) - g;
 
endfunction 
%-------------------------------------------------------------------------------
% ��������� �������
%-------------------------------------------------------------------------------

% ��������� ��������� �������
global gamma = 7800; 
% ����������� ������������� ����� (��� ����)
global c_f = 0.47;
% ������
global d = 0.1;

%-------------------------------------------------------------------------------
% ��������� ��������
%-------------------------------------------------------------------------------

% ��������� ��������
global v0 = 400;
% ���� ������� ������ ����� (� ��������!)
global alpha = 35;

%-------------------------------------------------------------------------------
%   ������ ����� ������� ���������� ��� ������������� ������� �������
%-------------------------------------------------------------------------------
function Y = MotionOdeSolve(v0, alpha, t)
   
  % ��������� �������
  x0 = 0;
  y0 = 0;
  vx0 = v0 * cos(deg2rad(alpha));
  vy0 = v0 * sin(deg2rad(alpha));
  
  Y0 = [x0; y0; vx0; vy0];
  
  % ������ ��� ��������
  solv = lsode("f_air", Y0, [0; t]);
  
  % ��������� ������ ������� ��������� ��� ������� ������� t
  Y = [solv(2,1); solv(2,2); solv(2,3); solv(2,4)];
  
endfunction

%-------------------------------------------------------------------------------
% ���������� ������ ������ ������� ��� ������������� ������� �������
%-------------------------------------------------------------------------------
function h = height(t)
  
  global v0;
  global alpha;
  
  Y = MotionOdeSolve(v0, alpha, t);
  
  h = Y(2);
  
endfunction

t1 = 10;
t2 = 20;
printf("h(%f) = %f, h(%f) = %f\n", t1, height(t1), t2, height(t2));

%-------------------------------------------------------------------------------
% �������������� �������� ������� �� ������� �������� ��� ������������� t
%-------------------------------------------------------------------------------
function d = dist(t)
  
  global v0;
  global alpha;
  
  Y = MotionOdeSolve(v0, alpha, t);
  
  d = Y(1);
  
endfunction

%
% ������ ������ ������ ��������� ������ �������. ������� ������ ���������
%   height(t) = 0
% ������������ �������. 
%

% ����� ��������� �������� �����
t0 = 0;
tend = 100.0;
deltaT = 1.0;

t = t0;

while (height(t) >= 0)
  t = t + deltaT;  
endwhile

b = height(t);
a = height(t - deltaT);

% ������ ����������� �����
t1 = t - deltaT / 2;

% �������� ������
t_end = fsolve("height", t1);

% ���������� ��������� ��������
d_max = dist(t_end);

printf("Shot distance: %f, m\n", d_max);

%-------------------------------------------------------------------------------
% ���������� ������������ �������� ������� ��������
%-------------------------------------------------------------------------------
function v = vy(t)
  
  global v0;
  global alpha;
  
  Y = MotionOdeSolve(v0, alpha, t);
  
  v = Y(4);
  
endfunction

%
% ������ ������ ������ ������������ ������ ������� �������. ������� ������ 
% ���������
%
% vy(t) = 0
%

% ���� �������� �������� �����
t = t0;

while (vy(t) >= 0)
  t = t + deltaT;  
endwhile

b = vy(t);
a = vy(t - deltaT);

% ������ ����������� �����
t1 = t - deltaT / 2;

% �������� ������
t_hmax = fsolve("vy", t1);

% ������� ������������ ������ ������� �������
h_max = height(t_hmax);

printf("Maximal height: %f, m\n", h_max);
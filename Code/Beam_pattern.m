%% Beam pattern
function [temp1, temp2] = Beam_pattern(nbest_pos)

% load('nbest.mat');
% load('light_record.mat');
numTX = 6;
numRX =12;
n = 1;
[ns, virtual_array] = cal_location(n, nbest_pos, numTX, numRX);
phi0 = 0*pi/180; 
theta0 = 0*pi/180;  
eps = 0.0001; 
NA = 360; 
NE = 360; 
lambda1 = 1;
virtual_array = cell2mat(virtual_array);
phi = linspace(-pi/2,pi/2,NA); 
theta = linspace(-pi/2,pi/2,NE); 
virtual = virtual_array(1,:)+sqrt (-1) .*virtual_array(2,:); 
for i = 1:length (phi)
    for j = 1:length(theta)  
        pattern0 = exp(sqrt(-1)*2*pi/lambda1*(sin(phi(i))*cos(theta(j))*real(virtual)+sin(theta(j))*imag(virtual))-sin(phi0)*cos(theta0)*real(virtual)-sin(theta0)*imag(virtual)); 
        pattern(i,j) = sum(sum(pattern0) ); 
    end 
end 
max_p = max(max(abs (pattern))); 
pattern_dbw = 20*log10(abs(pattern)/max_p+eps); 
number = find(pattern_dbw<-50); 
g_temp = -50+unifrnd(-1,1,1,length(number)); 
for j = 1:length(number) 
pattern_dbw(number(j)) = g_temp(j); 
end 
temp1 = pattern_dbw(:, round (NE* ((pi/2-theta0)/pi)));
[SLL_azi] = sidelobe_peak(temp1);
temp2 = pattern_dbw (round (NA* ((pi/2-phi0)/pi)),:);
[SLL_ele] = sidelobe_peak(temp2);
end



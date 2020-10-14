function hsi = rgb2hsi(rgb) 
rgb = im2double(rgb); 
r = rgb(:, :, 1); 
g = rgb(:, :, 2); 
b = rgb(:, :, 3); 
H = acos((((r - g) + (r - b))/2)./(sqrt((r - g).^2 + (r - b).*(g - b)) + eps)); 
H(b > g) = 2*pi - H(b > g); 

min_num = min(min(r, g), b); 
den = r + g + b; 
den(den == 0) = eps; 
S = 1 - 3.* min_num./den; 

H(S == 0) = 0; 
I = (r + g + b)/3; 
hsi = cat(3, H, S, I); 
function rgb = hsi2rgb(hsi) 
H = hsi(:, :, 1); 
S = hsi(:, :, 2); 
I = hsi(:, :, 3); 
sizeH=size(hsi,1);
sizeS=size(hsi,2);

R = zeros(sizeH, sizeS); 
G = zeros(sizeH, sizeS); 
B = zeros(sizeH, sizeS); 
%分段处理计算
index = find( (0 <= H) & (H < 2*pi/3)); 
indexI=I(index);
indexS=S(index);
indexH=H(index);
B(index) = indexI .* (1 - indexS); 
R(index) = indexI .* (1 + indexS .* cos(indexH) ./ cos(pi/3 - indexH)); 
G(index) = 3*indexI - (R(index) + B(index)); 

index = find( (2*pi/3 <= H) & (H < 4*pi/3) ); 
indexI=I(index);
indexS=S(index);
indexH=H(index);
R(index) = indexI .* (1 - indexS); 
G(index) = indexI .* (1 + indexS .* cos(indexH - 2*pi/3) ./ cos(pi - indexH)); 
B(index) = 3*indexI - (R(index) + G(index)); 

index = find( (4*pi/3 <= H) & (H <= 2*pi)); 
indexI=I(index);
indexS=S(index);
indexH=H(index);
G(index) = indexI .* (1 - indexS); 
B(index) = indexI .* (1 + indexS .* cos(indexH - 4*pi/3) ./cos(5*pi/3 - indexH)); 
R(index) = 3*indexI - (G(index) + B(index)); 

rgb = cat(3, R, G, B); 

idx=rgb>1;
rgb(idx)=1;
idx=rgb<0;
rgb(idx)=0;

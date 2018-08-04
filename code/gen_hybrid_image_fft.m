function [hybrid_image,low_frequencies,high_frequencies] = gen_hybrid_image_fft( image1, image2, cutoff_frequency )
pkg load image;

low_frequencies = []; %imagem com as componentes em baixa frequencia

figure, imshow(image1); % print da imagem1
b = padarray(image1, size(image1), "zeros", "post"); % faz o padarray da imagem1 com 0
c = im2double(b(:,:,1:3)); % transforma as componentes em double
d = fft2(c); % realiza a transformada de fourier 2D
d = fftshift(d); % Desloca a componente DC para o centro da imagem
figure, imshow(uint8(abs(d))); %print da imagem resultado apos a transformada d

[n m o] = size(c); %faz um vetor auxiliar do mesmo tamanho da imagem
h = zeros([n,m]); %cria uma matriz de zeros
for i = 1:n
for j = 1:m
h(i,j) = H(i,j,size(c),cutoff_frequency); %calcula o filtro e salva em h
end
end
figure, imshow(im2uint8(h)); %print da imagem de resultado h


g = d.*h; % multiplicacao de cada componente da imagem transformada com o filtro

g = ifftshift(g); % faz o shift de g
at = ifft2(g); % realiza a transformada inversa de fourier 2D
[x y o] = size(image1); % cria um vetor auxiliar do mesmo tamanho da imagem1
atc = at(1:x,1:y, :); % salva a imagem final em atc

figure, imshow(low_frequencies = atc); % print da imagem resultado em baixa frequencia low_frequencies

high_frequencies = []; %imagem com as componentes em alta frequencia

figure, imshow(image2); % print da imagem2
b = padarray(image2, size(image2), "zeros", "post"); % faz o padarray da imagem2 com 0
c = im2double(b(:,:,1:3)); % transforma as componentes em double
d = fft2(c); % realiza a transformada de fourier 2D
d = fftshift(d); % Desloca a componente DC para o centro da imagem
figure, imshow(uint8(abs(d))); %print da imagem resultado apos a transformada d

[n m o] = size(c); %faz um vetor auxiliar do mesmo tamanho da imagem
h = zeros([n,m]); %cria uma matriz de zeros
for i = 1:n
for j = 1:m
h(i,j) = H(i,j,size(c),cutoff_frequency); %calcula o filtro e salva em h
end
end

h = imcomplement(h); %calcula a inversa do filtro obtido em h

g = d.*h; % multiplicacao de cada componente da imagem transformada com o filtro

g = ifftshift(g); % faz o shift de g
at = ifft2(g); % realiza a transformada inversa de fourier 2D
[x y o] = size(image1); % cria um vetor auxiliar do mesmo tamanho da imagem1
atc = at(1:x,1:y, :); % salva a imagem final em atc

figure, imshow(high_frequencies = atc);  % print da imagem resultado em baixa frequencia high_frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hybrid_image = abs(low_frequencies + high_frequencies); % criacao da imagem hibrida

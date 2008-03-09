function [ I ] = jpeg_decode( R, taux )
    [m n] = size(R);
    I = uint8(zeros(m*8,n*8));
    Q = DefaultQuantizationMatrix();
    for i=1:m
        for j=1:n
            I(i*8-7:i*8,j*8-7:j*8)= uint8(idct2(R{i,j}.*Q*taux)+128);
        end
    end
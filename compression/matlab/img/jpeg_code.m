function [ R ] = jpeg_code( I, taux )

    B = BlockSplitting(I);
    [m n] = size(B);
    R = cell(m,n);
    Q = DefaultQuantizationMatrix();
    for i=1:m*n
        R{i}=round(dct2(double(B{i})-128)./Q/taux);
    end
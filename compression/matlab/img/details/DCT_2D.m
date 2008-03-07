function F=DCT_2D(f)

[NY,NX]=size(f);

Matrix_X=zeros(NX,NX);
x=0:(NX-1);
for n=0:(NX-1)
    Matrix_X(:,n+1)=cos(pi*(2*x+1)*n/(2*NX))';
end

Matrix_Y=zeros(NY,NY);
y=0:(NY-1);
for m=0:(NY-1)
    Matrix_Y(m+1,:)=cos(pi*(2*y+1)*m/(2*NY));
end

coef=ones(NY,NX);
coef(1,:)=coef(1,:)*1/sqrt(2);
coef(:,1)=coef(:,1)*1/sqrt(2);
coef=coef*2/sqrt(NY*NX);

F=coef.*(Matrix_Y*double(f)*Matrix_X);
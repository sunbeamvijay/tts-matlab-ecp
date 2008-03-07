function f=IDCT_2D(F)

[NY,NX]=size(F);

Matrix_X=zeros(NX,NX);
x=0:(NX-1);
for n=0:(NX-1)
    Matrix_X(:,n+1)=cos(pi*(2*n+1)*x/(2*NX))';
end

Matrix_Y=zeros(NY,NY);
y=0:(NY-1);
for m=0:(NY-1)
    Matrix_Y(m+1,:)=cos(pi*(2*m+1)*y/(2*NY));
end

coef=ones(NY,NX);
coef(1,:)=coef(1,:)*1/sqrt(2);
coef(:,1)=coef(:,1)*1/sqrt(2);
coef=coef*2/sqrt(NY*NX);

f=Matrix_Y*(coef.*F)*Matrix_X;
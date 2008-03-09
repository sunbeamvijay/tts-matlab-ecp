function [ Pal, II ] = palette( I , num_color)

    [nn mm c] = size(I);
    if c~=3 , error('pas en couleur'); end
    
    B.points = reshape(I,nn*mm,3);
    B.indices = 1:nn*mm;
    B.r1 = min(B.points(:,1));
    B.g1 = min(B.points(:,2));
    B.b1 = min(B.points(:,3));
    B.r2 = max(B.points(:,1));
    B.g2 = max(B.points(:,2));
    B.b2 = max(B.points(:,3));
    
    P=cell(num_color,1);
    extend=zeros(num_color,1);
    P{1}=B;
    extend(1)= max([B.r2-B.r1,B.g2-B.g1,B.b2-B.b1]);
    
    for i = 1:num_color-1
        [v,I] = max(extend(1:i));
        B = P{I};
        if v==B.r2-B.r1
            c = 1;
        elseif v==B.g2-B.g1
            c=2;
        else
            c=3;
        end
        m = median(B.points(:,c));
        [C,extend(I)] = box(B.points(B.points(:,c)<=m,:));
        C.indices = B.indices(B.points(:,c)<=m);
        [D,extend(i+1)] = box(B.points(B.points(:,c)>m,:));
        D.indices = B.indices(B.points(:,c)>m);
        P{I}=C;
        P{i+1}=D;       
    end
    
    Pal = zeros(num_color,3);
    II = zeros(nn,mm);
    for i = 1:num_color
        Pal(i,1)=mean(P{i}.points(:,1));
        Pal(i,2)=mean(P{i}.points(:,2));
        Pal(i,3)=mean(P{i}.points(:,3));
        II(P{i}.indices)=i;
    end
    
    
function [bB,e] = box(points)
    bB.points = points;
    bB.r1 = min(points(:,1));
    bB.g1 = min(points(:,2));
    bB.b1 = min(points(:,3));
    bB.r2 = max(points(:,1));
    bB.g2 = max(points(:,2));
    bB.b2 = max(points(:,3));
    e=max([bB.r2-bB.r1,bB.g2-bB.g1,bB.b2-bB.b1]);
function [Res] = artstyle(I, celulas,nucleos, minInt, maxInt)

[u,v] = size(I);

I = double(I);


maxOriginal = max(max(I)); 
minOriginal = min(min(I));

rango = double(maxInt - minInt)/double(maxOriginal - minOriginal);

originalMod(:,:) = I(:,:) - double(minOriginal);
originalMod = originalMod.*rango;
originalMod = originalMod + minInt;

back = zeros(u,v,3);
front = zeros(u,v,3);
edges = zeros(u,v,3);


back(:,:,1) = originalMod(:,:);
back(:,:,2) = originalMod(:,:);
back(:,:,3) = originalMod(:,:);

for i=1:u
    for j=1:v
        
        if celulas(i,j) ==  255
            front(i,j, 3) = 255; 
        end
        
        if nucleos(i,j) ==  255

            front(i,j, 2) = 255; 
        end
        
        
    end
end

se2 = strel('disk', 4,4);
edgCell = edge(celulas, 'Canny');
edgCell = imdilate(edgCell, se2);
edgNuc = edge(nucleos, 'Canny');
edgNuc = imdilate(edgNuc, se2);


for i=1:u
    for j=1:v
        
        if edgCell(i,j) ==  1 || edgNuc(i,j) ==  1
            edges(i,j, 1) = 255;
            edges(i,j, 2) = 0;
            edges(i,j, 3) = 0;
        end
    end
end

Res = front + back + edges;
% imshow(uint8(Res))


end



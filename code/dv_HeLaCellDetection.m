
function [edges, edges_O, edges_R, nucleos, cell, propNuc, propCell, resCell] = dv_HeLaCellDetection(I, files)


IO = I;

I = imresize(I, [500 500]);

[u,v] = size(I);



%% nucleos
% J = rangefilt(Ig);
Ig = imgaussfilt(I,.2);
J = stdfilt(Ig);
%imwrite(uint8(J), strcat(pathSave,'01_proposed_variables\nuclei\02_LSD\',files));
% J = entropyfilt(mEnt_gauss);
edges = edge(J, 'canny');




se = strel('diamond', 2);
edges = imdilate(edges, se);



newShape = zeros(u,v);
for i=1:u
    for j=1:v
        if edges(i,j) == 255 || edges(i,j) == 1
            newShape(i,j) = 0;
        else 
            newShape(i,j) = 255;
        end
    end
end


bw = bwareaopen(newShape,300);
Res = imfill(bw,'holes');

CC = bwconncomp(Res, 4);
numPixels = cellfun(@numel, CC.PixelIdxList);
[tamx,tamy] = size(numPixels);

nucleos = zeros(u,v);
for k=1:tamy
    if numPixels(k) >= 400 && numPixels(k) < 40000
        nucleos(CC.PixelIdxList{k}) = 255;
    end
end
propNuc = nucleos;


%% celulas
IO = imgaussfilt(IO,2);
BW = im2bw(IO, graythresh(IO));
BW = one2zero(BW);
BW = bwareaopen(BW,3000);
se = strel('sphere', 1);
BW_close = imclose(BW, se);
BW_close = uint8(BW_close*255);


toedges = imresize(BW_close, [500 500]);
edges_O = edge(toedges, 'canny');
se = strel('diamond', 1);
edges_O = imdilate(edges_O, se);


se1 = strel('diamond', 58);
BW_er = imerode(BW_close, se1);



% BW_dil = imdilate(BW_er, se1);

%células propuestas
BW_holes = imfill(BW_er,'holes');

propCell = BW_holes; 


%% verificar celulas y nucleos
propCells = imresize(BW_holes, [500 500]);
CC_cell = bwconncomp(propCells);
numCells = cellfun(@numel, CC_cell.PixelIdxList);
[x_c,y_c] = size(numCells);
CC_nuc = bwconncomp(nucleos);
numNucs = cellfun(@numel, CC_nuc.PixelIdxList);
[x_n,y_n] = size(numNucs);


realNucs = zeros(u,v);
realCells = zeros(u,v);
x_img = u/2;
y_img = v/2;


if y_c ~= 0
    for n=1:y_n
        nuc = zeros(u,v);
        nuc(CC_nuc.PixelIdxList{n}) = 255;
        [xN, yN] = centros(nuc);
        for c=1:y_c
            cell = zeros(u,v);
            cell(CC_cell.PixelIdxList{c}) = 255;
            [xC, yC] = centros(cell);
            dC = sqrt((xC - x_img)*(xC - x_img) + (yC - y_img)*(yC - y_img));           
            if dC < 40
                realCells(CC_cell.PixelIdxList{c}) = 255; 
                d = sqrt((xC - xN)*(xC - xN) + (yC - yN)*(yC - yN));
                if d < 110 %60
                    realNucs(CC_nuc.PixelIdxList{n}) = 255;  
                end
            end
        end
    end  
end

nucleos = realNucs;
cell = realCells;

se = strel('sphere', 10);
cell = imdilate(cell, se);
cell = imfill(cell,'holes');

edges_R = edge(cell, 'canny');
se = strel('diamond', 1);
edges_R = imdilate(edges_R, se);
se = strel('diamond', 1);
nucleos = imdilate(nucleos, se); %%volver a poner

resCell = dv_closeCells(I, edges_R, edges_O);
resCell = bwareaopen(resCell,100);

nucleos = dv_checkNucinCell(resCell, nucleos);
nucleos = dv_checkRound(nucleos);

%%
nucMay = nucleos;
nucleos = zeros(u,v);
CC_nuc = bwconncomp(nucMay);
numNucs = cellfun(@numel, CC_nuc.PixelIdxList);
[x_n,y_n] = size(numNucs);
if y_n ~= 0
    valMax = max(max(numNucs));
    nucleos(CC_nuc.PixelIdxList{find(valMax)}) = 255;
end

nucleos = dv_closeNucleis(I, nucleos, resCell);




%%


% cpaint = zeros(u,v,3);
% cpaint(:,:,1) = I;
% cpaint(:,:,2) = I;
% cpaint(:,:,3) = I;
% 
% for i=1:u
%     for j=1:v
%         if cell(i,j) == 255
%             cpaint(i,j,1) = 0;
%             cpaint(i,j,2) = I(i,j);
%             cpaint(i,j,3) = 0;
%         end
%     end
% end
end






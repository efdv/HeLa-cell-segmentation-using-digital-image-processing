%% this code is for draw labeled nuclei with component connected
% function C = dv_visualLabeledCC(I)
pathSave = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\Procesamiento\visualRes\';
I = imread('..\..\..\new_code\results_efdv-jcn\03_propNuc\100.png');
[u,v] = size(I);
CC = bwconncomp(I);
numNucs = cellfun(@numel, CC.PixelIdxList);
[x,y] = size(numNucs);
C = zeros(u,v,3);

x_img = u/2;
y_img = v/2;


for k=1:y
    nuc = zeros(u,v);
    nuc(CC.PixelIdxList{k}) = 255;
    [xC, yC] = centros(nuc);
   % d = sqrt((xC - x_img)*(xC - x_img) + (yC - y_img)*(yC - y_img)); 
    statsN = regionprops(nuc,'Area');
    [tamx, tamy] = size(statsN);
    area = statsN(tamx).Area;
    r = randi([0 255],1,1);
    g = randi([0 255],1,1);
    b = randi([0 255],1,1);

    if area > 3
%     if d > 110
        for i=1:u
            for j=1:v
                if nuc(i,j) == 255 || nuc(i,j) == 1 
                    C(i,j,1) = r;
                    C(i,j,2) = g;
                    C(i,j,3) = b;
                end
            end
        end
    else
        for i=1:u
            for j=1:v
                if nuc(i,j) == 255 || nuc(i,j) == 1 
                    C(i,j,1) = 255;
                    C(i,j,2) = 255;
                    C(i,j,3) = 255;
                end
            end
        end
    end

%         %vecindad
%     for i =1:3
%         for j = 1:3
%             C(floor(xC)+i-2,floor(yC)+j-2, 1) = 255;
%             C(floor(xC)+i-2,floor(yC)+j-2, 2) = 0;
%             C(floor(xC)+i-2,floor(yC)+j-2, 3) = 0;
%         end
%     end

%     C(floor(xC),floor(yC), 1) = 255;
%     C(floor(xC),floor(yC), 2) = 0;
%     C(floor(xC),floor(yC), 3) = 0;
% C(:,:,1) = C(:,:,1) + nuc(:,:);
% C(:,:,2) = C(:,:,2) + nuc(:,:);
% C(:,:,3) = C(:,:,3) + nuc(:,:);
end
imshow(uint8(C))
% imwrite(uint8(C), '..\..\results_efdv-jcn\Results\article\nucdis100.png')
% end
% imwrite(uint8(C), strcat(pathSave, '06_230.png'))


%% Cells

BW_close = imread('C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\Procesamiento\01_proposed_variables\cell\05_closing\230.png');
imshowpair(BW_close,BW_close,'montage');
drawnow
se1 = strel('diamond', 58);
BW_er = imerode(BW_close, se1);
imshowpair(BW_close,BW_er,'montage');
drawnow


% BW = im2bw(IO, graythresh(IO));
% imshow(BW)
% drawnow limitrate;
% 
% BW = one2zero(BW);
% imshow(BW)
% drawnow limitrate;
% 
% BW = bwareaopen(BW,3000);
% imshow(BW)
% drawnow limitrate;
% 
% se = strel('sphere', 1);
% BW_close = imclose(BW, se);
% imshow(BW_close)
% drawnow limitrate;
% 
% BW_close = uint8(BW_close*255);
% imshow(BW_close)
% drawnow limitrate;
% 
% 
% se1 = strel('diamond', 58);
% BW_er = imerode(BW_close, se1);
% imshow(BW_er)
% drawnow limitrate;
% 
% 
% 
% %células propuestas
% BW_holes = imfill(BW_er,'holes');
% imshow(BW_holes)
% drawnow limitrate;
% 
% propCell = BW_holes; 
% imshow(propCell)
% drawnow limitrate;
% 


%% cell distance from center
pathSavetxt = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\Procesamiento\';
pathLoad = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\';
read_propCell = dir([strcat(pathLoad, '02_propCells\'), '*.png']);

file = fopen(strcat(pathSavetxt,'dis_cellfromcenter.txt'),'w');
fprintf(file,'No.Image\tNoObj\tdistancia\n');
for k=1:300
    fprintf('%i\n', k);
    files = read_propCell(k).name;
    propCells = imread(strcat(pathLoad,'02_propCells\', files));
    propCells = imresize(propCells, [500 500]);

    [u,v] = size(propCells);
    CC_cell = bwconncomp(propCells);
    numCells = cellfun(@numel, CC_cell.PixelIdxList);
    [x_c,y_c] = size(numCells);

    x_img = u/2;
    y_img = v/2;
    
    if y_c ~= 0
        dC = zeros(1,y_c);
        for c=1:y_c
            cell = zeros(u,v);
            cell(CC_cell.PixelIdxList{c}) = 255;
            [xC, yC] = centros(cell);
            dC = sqrt((xC - x_img)*(xC - x_img) + (yC - y_img)*(yC - y_img));   
            fprintf(file,'%i\t%i\t%f\n',k,c,dC);
%             if dC < 166
% %                 x = 1:1:length(dC);
%                 swarmchart(c,dC,'filled', 'blue')
%             else
%                 swarmchart(c,dC,'filled', 'red')
%             end

        end
       
    end

%     x = 1:1:length(dC);
%     swarmchart(x,dC,'filled', 'red')
% 
%     hold on
%     hold on 

                                                                                                                                                                              
end

% xlabel('Cantidad de objetos')
% ylabel('Distanncia')
% title('Distancia célula propuesta al centro')

%% nuclei distance from cell
pathSavetxt = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\Procesamiento\';
pathLoad = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\';
read_propCell = dir([strcat(pathLoad, '02_propCells\'), '*.png']);
read_propNuc =  dir([strcat(pathLoad, '03_propNuc\'), '*.png']);

file = fopen(strcat(pathSavetxt,'dis_nucfromcell.txt'),'w');
fprintf(file,'No.Image\tNoObj\tNoCell\tdisNucCent\tdisNucCell\n');


for k=1:300
    fprintf('%i\n', k);
    filesCell = read_propCell(k).name;
    filesNuc  =  read_propNuc(k).name;
    
    propCells = imread(strcat(pathLoad,'02_propCells\', filesCell));
    propNucs  = imread(strcat(pathLoad,'03_propNuc\', filesNuc));

    propCells = imresize(propCells, [500 500]);

    [u,v] = size(propCells);
    CC_cell = bwconncomp(propCells);
    numCells = cellfun(@numel, CC_cell.PixelIdxList);
    [x_c,y_c] = size(numCells);

    CC_nuc = bwconncomp(propNucs);
    numNucs = cellfun(@numel, CC_nuc.PixelIdxList);
    [x_n,y_n] = size(numNucs);

    x_img = u/2;
    y_img = v/2;
    cont = 0;

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
    %             fprintf(file1,'%s\t%f\t%f\n',files,dC,d);
                if dC < 45
                    
                    d = sqrt((xC - xN)*(xC - xN) + (yC - yN)*(yC - yN));
%                     if d < 50 %60
                       fprintf(file,'%i\t%i\t%i\t%f\t%f\n',k,n,c,dC, d);
%                     end
                end
            end
        end  
    end
    
%     if y_c ~= 0
%          for c=1:y_c
%              cell = zeros(u,v);
%              cell(CC_cell.PixelIdxList{c}) = 255;
%              [xC, yC] = centros(cell);
%              dC = sqrt((xC - x_img)*(xC - x_img) + (yC - y_img)*(yC - y_img));
%              if dC < 50
%                  d = zeros(1,y_n);
%                  for n=1:y_n
%                     nuc = zeros(u,v);
%                     nuc(CC_nuc.PixelIdxList{n}) = 255;
%                     [xN, yN] = centros(nuc);
%                     d = sqrt((xC - xN)*(xC - xN) + (yC - yN)*(yC - yN));
%                     fprintf(file,'%i\t%i\t%i\t%f\t%f\n',k,n,c,dC, d);
%                  end
%              end
%          end
%     end

%     x = 1:1:length(d);
%     swarmchart(k,d,'filled', 'blue')
%     scatter(k,d,'filled', 'blue')
% 
%     hold on
                                                                                                                                                                          
end

% xlabel('Cantidad de objetos')
% ylabel('Distanncia')
% title('Distancia célula propuesta al centro')
% 
% hold off

%%   check round nuclei

pathSavetxt = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\Procesamiento\';
pathLoad = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\';
read_propNuc =  dir([strcat(pathLoad, 'Procesamiento\04_checkround\nuclei\'), '*.png']);

file = fopen(strcat(pathSavetxt,'checkround.txt'),'w');
fprintf(file,'No.Image\tNoNuc\tround\n');

for k=1:300
    fprintf('%i\n', k);
    filesNuc  =  read_propNuc(k).name;
    
    nucleos  = imread(strcat(pathLoad,'Procesamiento\04_checkround\nuclei\', filesNuc));

    [u,v] = size(nucleos);
    nucleos = bwareaopen(nucleos,500);
    CC = bwconncomp(nucleos);
    numNucs = cellfun(@numel, CC.PixelIdxList);
    [x,y] = size(numNucs);
    nucR = zeros(u,v);
    
   
    if numNucs ~= 0
        for i=1:y
              obj = zeros(u,v);
              obj(CC.PixelIdxList{i}) = 255;
              [B,L] = bwboundaries(obj,'noholes');
              stats = regionprops(L,'Area','Centroid');
              boundary = B{1};
              delta_sq = diff(boundary).^2;    
              perimeter = sum(sqrt(sum(delta_sq,2)));
              area = stats(1).Area;
              metric = 4*pi*area/perimeter^2;
              fprintf(file,'%i\t%i\t%f\n',k,i,metric);
              if metric > 0.1
                    nucR(CC.PixelIdxList{i}) = 255;
              end
        end
    end
end


%% Visualización de núcleo en la célula 

pathSave = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\results_efdv-jcn\Procesamiento\visualRes\';
nucleos = imread('..\..\..\new_code\results_efdv-jcn\03_propNuc\100.png');
cells = imread('..\..\..\new_code\results_efdv-jcn\08_resCell\100.png');
[u,v] = size(cells);
CCn = bwconncomp(nucleos);
numNucs = cellfun(@numel, CCn.PixelIdxList);
[x,y] = size(numNucs);

CCc = bwconncomp(cells);
numCells = cellfun(@numel, CCc.PixelIdxList);


colorcell = zeros(u,v,3);
colorRes = zeros(u,v,3);

cell = zeros(u,v);
cell(CCc.PixelIdxList{1}) = 255;
colorcell(:,:,3) = cell(:,:);

for k=1:y
    disp(k)
    nuc = zeros(u,v);
    nuc(CCn.PixelIdxList{k}) = 255;
    
    %colornuc = zeros(u,v,3);
    colornuc(:,:,2) = nuc(:,:);
    colornuc(:,:,1) = 0;
    colornuc(:,:,3) = 0;
    
    color1 = colornuc + colorcell;
    imwrite(uint8(color1), strcat('..\..\results_efdv-jcn\Results\article\colorcell\colornuc100_1',int2str(k),'.png'))
    cont = 0;
    for i=1:u
        for j=1:v
            if nuc(i,j) == 255 && cell(i,j) == 0
                cont = cont + 1;
            end
        end
    end
    
    if cont > 0
         colornuc(:,:,1) = nuc(:,:);
         color1 = colornuc + colorcell;
    else
         colornuc(:,:,1) = nuc(:,:);
         colornuc(:,:,2) = nuc(:,:);
         colornuc(:,:,3) = nuc(:,:);
         color1 = colornuc + colorcell;
    end
    colorcell = color1;
     imwrite(uint8(colorcell), strcat('..\..\results_efdv-jcn\Results\article\colorcell\colornuc100_1_1',int2str(k),'.png'))
    
end










%%
I = imread('C:\Users\edgar\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\dataset\dataset_reyes\groundTrue\ROI_1656-6756-329/078.tif');
% %Obtain unique colors
colors = [];
[u,v] = size(I);
for i=1:u
    for j=1:v
        lenV = length(colors);
        cont = 0;
        if lenV ~= 0
            for m=1:lenV
                if I(i,j) == colors(m)
                    cont = cont + 1;
                end
            end

            if cont >= 1
            else
                colors(end+1) = I(i,j);
            end
            
        else
            colors(end+1) = I(i,j);
        end
    end
end
% 
% layers = zeros(u,v,length(colors));
% for k = 1:length(colors)
%     for i=1:u
%         for j=1:v
%             if I(i,j) == colors(k)
%                 layers(i,j,k) = 255;
%             end
%         end
%     end
% end
% 
% 
% %Capa 1
% figure(1)
% imshow(layers(:,:,1)) %celulas varias 153
% %Capa 2
% figure(2)
% imshow(layers(:,:,2)) %fondo 204
% %Capa 3
% figure(3)
% imshow(layers(:,:,3))%celula objetivo 255
% %Capa 4
% figure(4)
% imshow(layers(:,:,4))%borde del nucleo 51
% %Capa 5
% figure(5)
% imshow(layers(:,:,5))%Nucleo 102



path = 'C:\Users\edgar\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\dataset\dataset_reyes\groundTrue\ROI_1656-6756-329\';
read_file = dir([path, '*.tif']);

for k=1:length(read_file)
    fprintf('%i\n', k);
    files = read_file(k).name;
    I = imread(strcat(path,files));
    I = imresize(I, [500 500]);
    [u,v] = size(I);
    layers = zeros(u,v,length(colors));
    for m = 1:length(colors)
        for i=1:u
            for j=1:v
                if I(i,j) == colors(m)
                    layers(i,j,m) = 255;
                end
            end
        end
    end
    M = (layers(:,:,3)+layers(:,:,5));
    imwrite(layers(:,:,1), strcat(path,'other_cells\',files));
    imwrite(layers(:,:,2), strcat(path,'background\',files));
    imwrite(imfill(M,'holes'), strcat(path,'cell\',files));
    imwrite(layers(:,:,4), strcat(path,'edgeNuc\',files));
    imwrite(layers(:,:,5), strcat(path,'nuclei\',files));
end



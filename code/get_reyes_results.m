pathSaveN = 'C:\Users\edgar\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\dataset\dataset_reyes\resultados\nuclei\';
pathSaveC = 'C:\Users\edgar\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\new_code\dataset\dataset_reyes\resultados\cells\';
addpath(genpath('C:\Users\edgar\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestría\Codigos\Proyecto_reyes_karabag\HeLa-Cell-Segmentation\Code\'))
[u,v,c] = size(Hela_nuclei);

for k=1:c
    Hela_cell = zeros(u,v);
    [Hela_cell] = segmentCellHelaEM_3D(Hela_nuclei0(:,:,k),Hela_backgroundO(:,:,k));
    if k < 10
        valstr = strcat('00',int2str(k));
    end 

    if k >= 10 && k < 100
        valstr = strcat('0', int2str(k));
    end 

    if k >= 100
        valstr = int2str(k);
    end
    
    %imwrite(imresize(Hela_nuclei(:,:,k),[500 500]), strcat(pathSaveN,valstr, '.png') )
    imwrite(imresize(Hela_cell,[500 500]), strcat(pathSaveC,valstr, '.png') )
    fprintf("%i\n", k);
end 
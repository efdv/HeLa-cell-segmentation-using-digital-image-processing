clear all
clc

%addpath(genpath('C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\MainFolder\DICIVA\1. Maestr�a\ENERO - JUNIO 2021\Mecanizaci�n 2\Texturas\MATLAB\'))
%addpath(genpath('C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestr�a\Codigos\functions'))
%addpath(genpath('C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestr�a\Codigos\'))

%addpath(genpath('D:\onedrive-UGefdv\OneDrive - Universidad de Guanajuato\MainFolder\DICIVA\1. Maestr�a\ENERO - JUNIO 2021\Mecanizaci�n 2\Texturas\MATLAB\'))
%addpath(genpath('D:\onedrive-UGefdv\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestr�a\Codigos\functions'))
%addpath(genpath('D:\onedrive-UGefdv\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestr�a\Codigos\'))

%pathSave = 'C:\Users\ef.duquevazquez\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestr�a\Codigos\new_code\results_efdv-jcn\';
pathOriginales = '..\..\results_efdv-jcn\originales\ROI_1656-6756-329\';
read_imgO = dir([pathOriginales, '*.png']);
tic
for k=1:300
    fprintf('%i\n', k);
    files = read_imgO(k).name;
    I = imread(strcat(pathOriginales,files));
    [edges, edges_cell, edges_rCell, nucleos, celulas, propNuc, propCell, resCell] = dv_HeLaCellDetection(I, files);
    

   
    
    
%     imwrite(edges, strcat(pathSave,'04_edges\',files));
%     imwrite(nucleos, strcat(pathSave,'01_nucleis\',files));
%     imwrite(celulas, strcat(pathSave,'00_cells\',files));
%     imwrite(propCell, strcat(pathSave,'02_propCells\',files));
%     imwrite(propNuc, strcat(pathSave,'03_propNuc\',files));
%     imwrite(uint8(cpaint), strcat(pathSave,'05_cpaint\',files));
%     imwrite(edges_cell, strcat(pathSave,'06_edgesCell\',files));
%     imwrite(edges_rCell, strcat(pathSave,'07_rCell\',files));
%     imwrite(resCell, strcat(pathSave,'08_resCell\',files));
    
                                                                                                                                                                              
end
toc




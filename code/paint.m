clear all
clc
pathNucsefdv = '..\..\results_efdv-jcn\09_nucs2\';
pathCellsefdv = '..\..\results_efdv-jcn\08_resCell\';
pathO = '..\..\results_efdv-jcn\originales\ROI_1656-6756-329\All\';
read_nucsEFDV = dir([pathNucsefdv, '*.png']);
read_cellsEFDV = dir([pathCellsefdv, '*.png']);
read_I = dir([pathO, '*.png']);
DelayTime = 0.1; 
draw = zeros(500, 500, 3);
for k=1:300
    disp(k);
    files_ndv = read_nucsEFDV(k).name;
    files_cdv = read_cellsEFDV(k).name;
    files_I = read_I(k).name;
    I = imread(strcat(pathO,files_I));
    I = imresize(I, [500 500]);
    ndv = imread(strcat(pathNucsefdv, files_ndv));
    cdv = imread(strcat(pathCellsefdv, files_cdv));
    [Res] = overmask2(I, cdv,ndv, 50, 255);
    imwrite(uint8(Res), strcat('..\..\results_efdv-jcn\05_cpaint\', files_ndv))
end
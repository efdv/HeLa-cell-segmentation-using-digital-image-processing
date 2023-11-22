clear all
clc
pathNucsefdv = '..\..\results_efdv-jcn\09_nucs2\';
pathCellsefdv = '..\..\results_efdv-jcn\08_resCell\';
pathNucsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\nuclei500\';
pathCellsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\cell500\';
pathNucsReyes = '..\..\results_efdv-jcn\results_reyes\nuclei500\';
pathCellsReyes = '..\..\results_efdv-jcn\results_reyes\cells500\';

pathI = '..\..\results_efdv-jcn\originales\ROI_1656-6756-329\';

read_nucsEFDV = dir([pathNucsefdv, '*.png']);
read_cellsEFDV = dir([pathCellsefdv, '*.png']);
read_nucsREF = dir([pathNucsRef, '*.tif']);
read_cellsREF = dir([pathCellsRef, '*.tif']);
read_cellREYES = dir([pathCellsReyes, '*.png']);
read_nucsREYES = dir([pathNucsReyes, '*.png']);

read_I = dir([pathI, '*.png']);


vecNucsEFDV = zeros(1,300);
vecCellsEFDV = zeros(1,300);
vecNucsREYES = zeros(1,300);
vecCellsREYES = zeros(1,300);

comp = zeros(500, 500, 3);

acumNucsEFDV = zeros(1,300);
acumNucsREYES = zeros(1,300);
acumCellsEFDV = zeros(1,300);
acumCellsREYES = zeros(1,300);


for k=1:300
    disp(k);
    files_ndv = read_nucsEFDV(k).name;
    files_cdv = read_cellsEFDV(k).name;
    files_nref = read_nucsREF(k).name;
    files_cref = read_cellsREF(k).name;
    files_nrey = read_nucsREYES(k).name;
    files_crey = read_cellREYES(k).name;
    
    files_I = read_I(k).name;

    ndv = imread(strcat(pathNucsefdv, files_ndv));
    cdv = imread(strcat(pathCellsefdv, files_cdv));
    nref = imread(strcat(pathNucsRef, files_nref));
    cref = imread(strcat(pathCellsRef, files_cref));
    crey = imread(strcat(pathCellsReyes, files_crey));
    nrey = imread(strcat(pathNucsReyes, files_nrey));

    I = imread(strcat(pathI, files_I));
    I = imresize(I, [500, 500]);

    ndv = logical(ndv);
    cdv = logical(cdv);
    nref = logical(nref);
    cref = logical(cref);
    nrey = logical(nrey);
    crey = logical(crey);

    jacNucsEFDV = jaccard(ndv,nref);
    jacCellsEFDV = jaccard(cdv,cref);
    jacNucsREYES = jaccard(nrey,nref);
    jacCellsREYES = jaccard(crey,cref);

    if isnan(jacNucsEFDV)
        jacNucsEFDV = 1;
    end

    if isnan(jacCellsEFDV)
        jacCellsEFDV = 1;
    end

    if isnan(jacNucsREYES)
        jacNucsREYES = 1;
    end

    if isnan(jacCellsREYES)
        jacCellsREYES = 1;
    end


    vecNucsEFDV(1,k) = jacNucsEFDV;
    vecCellsEFDV(1,k) = jacCellsEFDV;
    vecNucsREYES(1,k) = jacNucsREYES;
    vecCellsREYES(1,k) = jacCellsREYES;
    
    acumNucsEFDV(1,k) = sum(vecNucsEFDV);
    acumNucsREYES(1,k) = sum(vecNucsREYES);
    acumCellsEFDV(1,k) = sum(vecCellsEFDV);
    acumCellsREYES(1,k) = sum(vecCellsREYES);

%     comp(:,:,1) = (nref(:,:)*255);
%     comp(:,:,3) = (ndv(:,:)*255);
% 
%     overcell = double(cdv).*double(I);
%     overnuc = double(ndv).*double(I);

    %imwrite(uint8(comp), strcat('..\..\results_efdv-jcn\Results\Comp\', files_ndv))

    %imwrite(uint8(overcell), strcat('..\..\results_efdv-jcn\11_overmaskcells\', files_ndv))
    %imwrite(uint8(overnuc), strcat('..\..\results_efdv-jcn\10_overmasknucs\', files_ndv))
    
end

% promNucsEFDV = mean(vecNucsEFDV);
% promCellsEFDV = mean(vecCellsEFDV);
% promNucsREYES = mean(vecNucsREYES);
% promCellsREYES = mean(vecCellsREYES);
% 
% stdNucsEFDV = std2(vecNucsEFDV);
% stdCellsEFDV = std2(vecCellsEFDV);
% stdNucsREYES = std2(vecNucsREYES);
% stdCellsREYES = std2(vecCellsREYES);
% 
% mNucsEFDV = median(vecNucsEFDV);
% mCellsEFDV = median(vecCellsEFDV);
% mNucsREYES = median(vecNucsREYES);
% mCellsREYES = median(vecCellsREYES);
% 
% % [~, pval, ~] = ztest(vecNucsEFDV, mean(vecNucsREYES), std(vecNucsREYES)/sqrt(length(vecNucsREYES)));
% % disp(pval)
% % 
% x = 1:1:300;
% ft = 'poly1';
% 
% figure(1)
% % [yData_dv, xData_dv] = prepareCurveData( vecCellsEFDV, x );
% % [fitresult_dv, gof] = fit( xData_dv, yData_dv, ft, 'Normalize', 'on' );
% % [yData_k, xData_k] = prepareCurveData( vecCellsREYES, x );
% % [fitresult_k, gof] = fit( xData_k, yData_k, ft, 'Normalize', 'on' );
% % 
% % t1 = plot( fitresult_dv,'r--');
% % t1.LineWidth = 2;
% % hold on 
% % t2  = plot( fitresult_k,'b-.');
% % t2.LineWidth = 2;
% % hold on 
% % t3 = plot(x,vecCellsEFDV,'Color', [.7,.7,.7]);
% % t3.LineStyle = ':' ;
% % t3.LineWidth = 1.5;
% % legend( 'Trend Proposal', 'Trend Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% % ylim([0.7 1])
% 
% % xlabel('Image index')
% % ylabel(' ');
% % title('Jaccard Index')
% 
% 
% %DATOS CRUDOS
% t1 = plot(x,vecCellsREYES,'Color', [0,0,1]);
% t1.LineStyle = '-' ;
% t1.LineWidth = 1.5;
% hold on 
% t2 = plot(x,vecCellsEFDV,'Color', [1,0,0]);
% t2.LineStyle = ':' ;
% t2.LineWidth = 1.5;
% legend( 'Results from Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% ylim([0.7 1])
% 
% xlabel('Image index')
% ylabel(' ');
% title('Jaccard Index')
% 
% 
% figure(2)
% % [yData_dv, xData_dv] = prepareCurveData( vecNucsEFDV, x );
% % [fitresult_dv, gof] = fit( xData_dv, yData_dv, ft, 'Normalize', 'on' );
% % [yData_k, xData_k] = prepareCurveData( vecNucsREYES, x );
% % [fitresult_k, gof] = fit( xData_k, yData_k, ft, 'Normalize', 'on' );
% % 
% % t1 = plot( fitresult_dv,'r--');
% % t1.LineWidth = 2;
% % hold on 
% % t2  = plot( fitresult_k,'b-.');
% % t2.LineWidth = 2;
% % hold on 
% % t3 = plot(x,vecNucsEFDV,'Color', [.7,.7,.7]);
% % t3.LineStyle = ':' ;
% % t3.LineWidth = 1.5;
% % legend( 'Trend Proposal', 'Trend Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% % ylim([0.7 1])
% % 
% % xlabel('Image index')
% % ylabel(' ');
% % title('Jaccard Index')
% 
% t1 = plot(x,vecNucsREYES,'Color', [0,0,1]);
% t1.LineStyle = '-' ;
% t1.LineWidth = 1.5;
% hold on 
% t2 = plot(x,vecNucsEFDV,'Color', [1,0,0]);
% t2.LineStyle = ':' ;
% t2.LineWidth = 1.5;
% legend( 'Results from Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% ylim([0.7 1])
% 
% xlabel('Image index')
% ylabel(' ');
% title('Jaccard Index')







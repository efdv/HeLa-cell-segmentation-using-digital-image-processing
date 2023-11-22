clear all
clc
pathNucsefdv = '..\..\results_efdv-jcn\09_nucs2\';
pathCellsefdv = '..\..\results_efdv-jcn\08_resCell\';
pathNucsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\nuclei500\';
pathCellsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\cell500\';
pathNucsReyes = '..\..\results_efdv-jcn\results_reyes\nuclei500\';
pathCellsReyes = '..\..\results_efdv-jcn\results_reyes\cells500\';

read_nucsEFDV = dir([pathNucsefdv, '*.png']);
read_cellsEFDV = dir([pathCellsefdv, '*.png']);
read_nucsREF = dir([pathNucsRef, '*.tif']);
read_cellsREF = dir([pathCellsRef, '*.tif']);
read_cellREYES = dir([pathCellsReyes, '*.png']);
read_nucsREYES = dir([pathNucsReyes, '*.png']);


vecNucsEFDV = zeros(1,300);
vecCellsEFDV = zeros(1,300);
vecNucsREYES = zeros(1,300);
vecCellsREYES = zeros(1,300);

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

    ndv = imread(strcat(pathNucsefdv, files_ndv));
    cdv = imread(strcat(pathCellsefdv, files_cdv));
    nref = imread(strcat(pathNucsRef, files_nref));
    cref = imread(strcat(pathCellsRef, files_cref));
    crey = imread(strcat(pathCellsReyes, files_crey));
    nrey = imread(strcat(pathNucsReyes, files_nrey));

    crey = imresize(crey, [500, 500]);

    ndv = logical(ndv);
    cdv = logical(cdv);
    nref = logical(nref);
    cref = logical(cref);
    nrey = logical(nrey);
    crey = logical(crey);

    nconfusionEFDV = confusionmat(ndv(:), nref(:));
    cconfusionEFDV = confusionmat(cdv(:), cref(:));
    nconfusionREYES = confusionmat(nrey(:), nref(:));
    cconfusionREYES = confusionmat(crey(:), cref(:));

    if length(nconfusionEFDV) > 1 &&  length(cconfusionEFDV) > 1 && length(nconfusionREYES) > 1 && length(cconfusionREYES) > 1

        nprecisionEFDV = nconfusionEFDV(2,2)/(nconfusionEFDV(2,2) + nconfusionEFDV(1,2));
        nrecallEFDV = nconfusionEFDV(2,2)/(nconfusionEFDV(2,2) + nconfusionEFDV(2,1));
        cprecisionEFDV = cconfusionEFDV(2,2)/(cconfusionEFDV(2,2) + cconfusionEFDV(1,2));
        crecallEFDV = cconfusionEFDV(2,2)/(cconfusionEFDV(2,2) + cconfusionEFDV(2,1));
        nprecisionREYES = nconfusionREYES(2,2)/(nconfusionREYES(2,2) + nconfusionREYES(1,2));
        nrecallREYES = nconfusionREYES(2,2)/(nconfusionREYES(2,2) + nconfusionREYES(2,1));
        cprecisionREYES = cconfusionREYES(2,2)/(cconfusionREYES(2,2) + cconfusionREYES(1,2));
        crecallREYES = cconfusionREYES(2,2)/(cconfusionREYES(2,2) + cconfusionREYES(2,1));
    
        F1NucsEFDV = 2 * (nprecisionEFDV * nrecallEFDV) / (nprecisionEFDV + nrecallEFDV);
        F1CellsEFDV = 2 * (cprecisionEFDV * crecallEFDV) / (cprecisionEFDV + crecallEFDV);
        F1NucsREYES = 2 * (nprecisionREYES * nrecallREYES) / (nprecisionREYES + nrecallREYES);
        F1CellsREYES = 2 * (cprecisionREYES * crecallREYES) / (cprecisionREYES + crecallREYES);
    else
        F1NucsEFDV = 1;
        F1CellsEFDV = 1;
        F1NucsREYES = 1;
        F1CellsREYES = 1;
    end

    if isnan(F1NucsEFDV)
        F1NucsEFDV = 0;
    end
    if isnan(F1CellsEFDV)
        F1CellsEFDV = 0;
    end
    if isnan(F1NucsREYES)
        F1NucsREYES = 0;
    end
    if isnan(F1CellsREYES)
        F1CellsREYES = 0;
    end


    vecNucsEFDV(1,k) = F1NucsEFDV;
    vecCellsEFDV(1,k) = F1CellsEFDV;
    vecNucsREYES(1,k) = F1NucsREYES;
    vecCellsREYES(1,k) = F1CellsREYES;
    
    %valor acumulado
    acumNucsEFDV(1,k) = sum(vecNucsEFDV);
    acumNucsREYES(1,k) = sum(vecNucsREYES);
    acumCellsEFDV(1,k) = sum(vecCellsEFDV);
    acumCellsREYES(1,k) = sum(vecCellsREYES);
    
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
% [~, pval, ~] = ztest(vecCellsEFDV, mean(vecCellsREYES), std(vecCellsREYES)/sqrt(length(vecCellsREYES)));
% disp(pval)
% 
% 
% 
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
% %   legend( 'Trend Proposal', 'Trend Karabag et al', 'Results from our proposal', 'Location', 'southwest')  
% 
% 
% %graficas versión2
% t1 = plot(x,vecCellsREYES,'Color', [0,0,1]);
% t1.LineStyle = '-' ;
% t1.LineWidth = 1.5;
% hold on 
% t2 = plot(x,vecCellsEFDV,'Color', [1,0,0]);
% t2.LineStyle = ':' ;
% t2.LineWidth = 1.5;
% legend( 'Results from Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% 
% ylim([0.7 1])
% xlabel('Image index')
% ylabel(' ');
% title('F1-score')
% 
% 
% figure(2)
% % [yData_dv, xData_dv] = prepareCurveData( vecNucsEFDV, x );
% % [fitresult_dv, gof] = fit( xData_dv, yData_dv, ft, 'Normalize', 'on' );
% % [yData_k, xData_k] = prepareCurveData( vecNucsREYES, x );
% % [fitresult_k, gof] = fit( xData_k, yData_k, ft, 'Normalize', 'on' );
% 
% 
% % t1 = plot( fitresult_dv,'r--');
% % t1.LineWidth = 2;
% % hold on
% % t2 = plot( fitresult_k,'b-.');
% % t2.LineWidth = 2;
% % hold on 
% % t3 = plot(x,vecNucsEFDV,'Color', [.7,.7,.7]);
% % t3.LineStyle = ':' ;
% % t3.LineWidth = 1.5;
% % legend( 'Trend Proposal', 'Trend Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% 
% %graficas versión2
% t1 = plot(x,vecNucsREYES,'Color', [0,0,1]);
% t1.LineStyle = '-' ;
% t1.LineWidth = 1.5;
% hold on 
% t2 = plot(x,vecNucsEFDV,'Color', [1,0,0]);
% t2.LineStyle = ':' ;
% t2.LineWidth = 1.5;
% legend( 'Results from Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% 
% ylim([0.7 1])
% xlabel('Image index')
% ylabel(' ');
% title('F1-score')
% 


clear all
clc
addpath(genpath('..\..\..\..\Codigos\'))

pathNucsefdv = '..\..\results_efdv-jcn\09_nucs2\';
pathCellsefdv = '..\..\results_efdv-jcn\08_resCell\';
pathNucsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\nuclei500\';
pathCellsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\cell500\';
%pathCellsRef = 'E:\Onedrive-efdv\OneDrive - Universidad de Guanajuato\EF-Duque-Vazquez-Maestria\Codigos\new_code\dataset\dataset_reyes\groundTrue\ROI_1656-6756-329\cell\';
pathFile = '..\..\results_efdv-jcn\NPR\';
pathNucsReyes = '..\..\results_efdv-jcn\results_reyes\nuclei500\';
pathCellsReyes = '..\..\results_efdv-jcn\results_reyes\cells500\';

[vecNucsEFDV,promEFDVnucs,mediaEFDVnucs, desviacionEFDVnucs] =  comp_npr(pathNucsefdv, 'png', pathNucsRef,'tif', [pathFile,'\nuclei\nuclei_efdv-230302---.txt']);
[vecNucsREYES, promedioREYESnucs,mediaREYESnucs, desviacionREYESnucs] =  comp_npr(pathNucsReyes, 'png', pathNucsRef,'tif', [pathFile,'\nuclei\nuclei_REYES-230302--.txt']);

[vecCellsEFDV,promEFDVcells,mediaEFDVcells, desviacionEFDVcells] =  comp_npr(pathCellsefdv, 'png', pathCellsRef,'tif', [pathFile,'\cell\cell_efdv-230306-----.txt']);
[vecCellsREYES, promedioREYEScells,mediaREYEScells, desviacionREYEScells] =  comp_npr(pathCellsReyes, 'png', pathCellsRef,'tif', [pathFile,'\cell\cell_REYES-230306-----.txt']);

nucsEFDV = 0;
nucsREYES = 0;
cellsEFDV = 0;
cellsREYES = 0;

acumNucsEFDV = zeros(1,300);
acumNucsREYES = zeros(1,300);
acumCellsEFDV = zeros(1,300);
acumCellsREYES = zeros(1,300);

for i=1:300
    nucsEFDV = double(nucsEFDV) + double(vecNucsEFDV(i,1));
    nucsREYES = nucsREYES + vecNucsREYES(i,1);
    cellsEFDV = cellsEFDV + vecCellsEFDV(i,1);
    cellsREYES = cellsREYES + vecCellsREYES(i,1);
    acumNucsEFDV(1,i) = nucsEFDV;
    acumNucsREYES(1,i) = nucsREYES;
    acumCellsEFDV(1,i) = cellsEFDV;
    acumCellsREYES(1,i) = cellsREYES;
end

% [~, pval, ~] = ztest(vecCellsEFDV, mean(vecCellsREYES), std(vecCellsREYES)/sqrt(length(vecCellsREYES)));
% disp(pval)
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
% % legend( 'Trend Proposal', 'Trend Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% % ylim([0.7 1])
% % xlabel('Image index')
% % ylabel(' ');
% % title('NPR')
% 
% 
% 
% %gráficasv2
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
% title('NPR')
% 
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
% 
% % xlabel('Image index')
% % ylabel(' ');
% % title('NPR')
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
% title('NPR')





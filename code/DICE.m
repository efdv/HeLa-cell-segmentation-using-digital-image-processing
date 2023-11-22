% clear all
% clc
% pathNucsefdv = '..\..\results_efdv-jcn\09_nucs2\';
% pathCellsefdv = '..\..\results_efdv-jcn\08_resCell\';
% pathNucsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\nuclei500\';
% pathCellsRef = '..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\cell500\';
% pathNucsReyes = '..\..\results_efdv-jcn\results_reyes\nuclei500\';
% pathCellsReyes = '..\..\results_efdv-jcn\results_reyes\cells500\';
% 
% read_nucsEFDV = dir([pathNucsefdv, '*.png']);
% read_cellsEFDV = dir([pathCellsefdv, '*.png']);
% read_nucsREF = dir([pathNucsRef, '*.tif']);
% read_cellsREF = dir([pathCellsRef, '*.tif']);
% read_cellREYES = dir([pathCellsReyes, '*.png']);
% read_nucsREYES = dir([pathNucsReyes, '*.png']);
% 
% % 
% vecNucsEFDV = zeros(1,300);
% vecCellsEFDV = zeros(1,300);
% vecNucsREYES = zeros(1,300);
% vecCellsREYES = zeros(1,300);
% 
% % vecNucsEFDV = zeros(1,210);
% % vecCellsEFDV = zeros(1,210);
% % vecNucsREYES = zeros(1,210);
% % vecCellsREYES = zeros(1,210);
% 
% acumNucsEFDV = zeros(1,300);
% acumNucsREYES = zeros(1,300);
% acumCellsEFDV = zeros(1,300);
% acumCellsREYES = zeros(1,300);
% 
% for k=1:300
% 
%     %if k >= 40 && k <= 250 
%         disp(k);
%         files_ndv = read_nucsEFDV(k).name;
%         files_cdv = read_cellsEFDV(k).name;
%         files_nref = read_nucsREF(k).name;
%         files_cref = read_cellsREF(k).name;
%         files_nrey = read_nucsREYES(k).name;
%         files_crey = read_cellREYES(k).name;
%     
%         ndv = imread(strcat(pathNucsefdv, files_ndv));
%         cdv = imread(strcat(pathCellsefdv, files_cdv));
%         nref = imread(strcat(pathNucsRef, files_nref));
%         cref = imread(strcat(pathCellsRef, files_cref));
%         crey = imread(strcat(pathCellsReyes, files_crey));
%         nrey = imread(strcat(pathNucsReyes, files_nrey));
%     
%         crey = imresize(crey, [500, 500]);
%     
%         ndv = logical(ndv);
%         cdv = logical(cdv);
%         nref = logical(nref);
%         cref = logical(cref);
%         nrey = logical(nrey);
%         crey = logical(crey);
%     
%         diceNucsEFDV = dice(ndv,nref);
%         diceCellsEFDV = dice(cdv,cref);
%         diceNucsREYES = dice(nrey,nref);
%         diceCellsREYES = dice(crey,cref);
%     
%         if isnan(diceNucsEFDV)
%             diceNucsEFDV = 1;
%         end
%     
%         if isnan(diceCellsEFDV)
%             diceCellsEFDV = 1;
%         end
%     
%         if isnan(diceNucsREYES)
%             diceNucsREYES = 1;
%         end
%     
%         if isnan(diceCellsREYES)
%             diceCellsREYES = 1;
%         end
%     
%     
%         vecNucsEFDV(1,k) = diceNucsEFDV;
%         vecCellsEFDV(1,k) = diceCellsEFDV;
%         vecNucsREYES(1,k) = diceNucsREYES;
%         vecCellsREYES(1,k) = diceCellsREYES;
%     
%       %valor acumulado
%       acumNucsEFDV(1,k) = sum(vecNucsEFDV);
%       acumNucsREYES(1,k) = sum(vecNucsREYES);
%       acumCellsEFDV(1,k) = sum(vecCellsEFDV);
%       acumCellsREYES(1,k) = sum(vecCellsREYES);
%     
% end
% 
% %valor acumulado
% x = 1:1:length(vecCellsREYES);
% 
% figure(1)
% t1 = plot(x,acumNucsEFDV,'Color', [0,0,1]);
% t1.LineStyle = '--';
% t1.LineWidth = 2;
% hold
% t2 = plot(x,acumNucsREYES,'Color', [1,0,0]);
% t2.LineStyle = ':';
% t2.LineWidth = 2;
% legend( 'Results from our proposal', 'Results from Karabag', 'Location', 'southeast')
% xlabel('Image index')
% ylabel(' ');
% %ylim([0.7 1])
% title('DICE')
% 
% figure(2)
% t1 = plot(x,acumCellsEFDV,'Color', [0,0,1]);
% t1.LineStyle = '--';
% t1.LineWidth = 2;
% hold
% t2 = plot(x,acumCellsREYES,'Color', [1,0,0]);
% t2.LineStyle = ':';
% t2.LineWidth = 2;
% legend( 'Results from our proposal', 'Results from Karabag', 'Location', 'southeast')
% xlabel('Image index')
% ylabel(' ');
% %ylim([0.7 1])
% title('DICE')
% 
% 
% % promNucsEFDV = mean(vecNucsEFDV);
% % promCellsEFDV = mean(vecCellsEFDV);
% % promNucsREYES = mean(vecNucsREYES);
% % promCellsREYES = mean(vecCellsREYES);
% % 
% % stdNucsEFDV = std2(vecNucsEFDV);
% % stdCellsEFDV = std2(vecCellsEFDV);
% % stdNucsREYES = std2(vecNucsREYES);
% % stdCellsREYES = std2(vecCellsREYES);
% % 
% % mNucsEFDV = median(vecNucsEFDV);
% % mCellsEFDV = median(vecCellsEFDV);
% % mNucsREYES = median(vecNucsREYES);
% % mCellsREYES = median(vecCellsREYES);
% % 
% % [~, pval, ~] = ztest(vecCellsEFDV, mean(vecCellsREYES), std(vecCellsREYES)/sqrt(length(vecCellsREYES)));
% % disp(pval)
% % 
% % 
% % x = 1:1:length(vecCellsREYES);
% % ft = 'poly1';
% % 
% % figure(1)
% % % [yData_dv, xData_dv] = prepareCurveData( vecCellsEFDV, x );
% % % [fitresult_dv, gof] = fit( xData_dv, yData_dv, ft, 'Normalize', 'on' );
% % % [yData_k, xData_k] = prepareCurveData( vecCellsREYES, x );
% % % [fitresult_k, gof] = fit( xData_k, yData_k, ft, 'Normalize', 'on' );
% % % 
% % % t1 = plot( fitresult_dv,'r--');
% % % t1.LineWidth = 2;
% % % hold on 
% % % t2  = plot( fitresult_k,'b-.');
% % % t2.LineWidth = 2;
% % % hold on 
% % % t3 = plot(x,vecCellsEFDV,'Color', [.7,.7,.7]);
% % % t3.LineStyle = ':' ;
% % % t3.LineWidth = 1.5;
% % % legend( 'Trend Proposal', 'Trend Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% % 
% % t1 = plot(x,vecCellsREYES,'Color', [0,0,1]);
% % t1.LineStyle = '-' ;
% % t1.LineWidth = 1.5;
% % hold on 
% % t2 = plot(x,vecCellsEFDV,'Color', [1,0,0]);
% % t2.LineStyle = ':' ;
% % t2.LineWidth = 1.5;
% % legend( 'Results from Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% % 
% % xlabel('Image index')
% % ylabel(' ');
% % ylim([0.7 1])
% % 
% % title('DICE')
% % 
% % 
% % figure(2)
% % % [yData_dv, xData_dv] = prepareCurveData( vecNucsEFDV, x );
% % % [fitresult_dv, gof] = fit( xData_dv, yData_dv, ft, 'Normalize', 'on' );
% % % [yData_k, xData_k] = prepareCurveData( vecNucsREYES, x );
% % % [fitresult_k, gof] = fit( xData_k, yData_k, ft, 'Normalize', 'on' );
% % % 
% % % t1 = plot( fitresult_dv,'r--');
% % % t1.LineWidth = 2;
% % % hold on 
% % % t2  = plot( fitresult_k,'b-.');
% % % t2.LineWidth = 2;
% % % hold on 
% % % t3 = plot(x,vecNucsEFDV,'Color', [.7,.7,.7]);
% % % t3.LineStyle = ':' ;
% % % t3.LineWidth = 1.5;
% % % legend( 'Trend Proposal', 'Trend Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% % 
% % t1 = plot(x,vecNucsREYES,'Color', [0,0,1]);
% % t1.LineStyle = '-' ;
% % t1.LineWidth = 1.5;
% % hold on 
% % t2 = plot(x,vecNucsEFDV,'Color', [1,0,0]);
% % t2.LineStyle = ':' ;
% % t2.LineWidth = 1.5;
% % legend( 'Results from Karabag et al', 'Results from our proposal', 'Location', 'southwest')
% % 
% % xlabel('Image index')
% % ylabel(' ');
% % ylim([0.7 1])
% % title('DICE')
% 
% 

number = '102';
dv = imread(strcat('..\..\results_efdv-jcn\08_resCell\',number,'.png'));
k = imread(strcat('..\..\results_efdv-jcn\results_reyes\cells500\', number,'.png'));
gt = imread(strcat('..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\cell500\', number,'.tif'));

% dv = imread(strcat('..\..\results_efdv-jcn\09_nucs2\',number,'.png'));
% k = imread(strcat('..\..\results_efdv-jcn\results_reyes\nuclei500\', number,'.png'));
% gt = imread(strcat('..\..\results_efdv-jcn\groundTrue\ROI_1656-6756-329\nuclei500\', number,'.tif'));

[u,v] = size(dv);
dvrgb = zeros(u,v,3);
dvrgb(:,:,1) = 0;
dvrgb(:,:,2) = 0;
dvrgb(:,:,3) = dv;

krgb = zeros(u,v,3);
krgb(:,:,1) = k*255;
krgb(:,:,2) = 0;
krgb(:,:,3) = 0;

gtrgb = zeros(u,v,3);
gtrgb(:,:,1) = 0;
gtrgb(:,:,2) = gt;
gtrgb(:,:,3) = 0;

% figure(1)
% imshow(dvrgb)
% figure(2)
% imshow(krgb)
% figure(3)
% imshow(gtrgb)

Rdv = dvrgb + gtrgb;
figure (4)
imshow(Rdv)

Rk = krgb + gtrgb;
figure (5)
imshow(Rk)

imwrite(Rdv,strcat('..\..\results_efdv-jcn\graphs\visualresults\cells\',number,'_dv.png'));
imwrite(Rk,strcat('..\..\results_efdv-jcn\graphs\visualresults\cells\',number,'_k.png'));

% imwrite(Rdv,strcat('..\..\results_efdv-jcn\graphs\visualresults\nucs\',number,'_dv.png'));
% imwrite(Rk,strcat('..\..\results_efdv-jcn\graphs\visualresults\nucs\',number,'_k.png'));



function [O] = dv_umbrales(I, noUmbrales) 

[u,v,c] = size(I);

    if c == 1
        h = dv_calc_hist(I); 
        Ha = dv_acuHist(h);
        maxpixel = max(max(Ha));
        pasos = (1/(noUmbrales+1))*maxpixel;
        color = 0;
        valor = 0;
        pasosColor = 255/noUmbrales;

        for k=1:1:noUmbrales+1
            valor = valor + pasos;
            color = color + pasosColor;
            for i=1:1:u
                for j=1:1:v
                    if Ha(I(i,j)+1) > valor && Ha(I(i,j)+1) < (valor + pasos)
                        O(i,j) = color;
                    end
                end
            end
        end
    end
    
    if c == 3
        O(:,:,1) = umbrales(I(:,:,1),noUmbrales);
        O(:,:,2) = umbrales(I(:,:,2),noUmbrales);
        O(:,:,3) = umbrales(I(:,:,3),noUmbrales);
    end

end
function I = dv_normalization(I,vmin, vmax)
    
    if vmin < 0 || vmin > 255
        fprintf('EL VALOR NO SE ENCUENTRA DENTRO DE LOS VALORES PERMITIDOS')
    end
    if vmax < 0 || vmax > 255
        fprintf('EL VALOR NO SE ENCUENTRA DENTRO DE LOS VALORES PERMITIDOS')
    end
    if vmin > vmax
        a = vmax;
        b = vmin;
        vmin = a;
        vmax = b;
    end
    
    [u,v,c] = size(I);
    I = double(I);
        
        
    if c == 1
        pmin = min(min(I));
        pmax = max(max(I)); 
        
        for i=1:u
            for j=1:v
                pixel = I(i,j);
                newpixel = ((pixel-pmin)/(pmax-pmin)*(vmax-vmin))+vmin;
                I(i,j) = newpixel;
            end
        end
    end
        
    if c == 3
        I(:,:,1) = dv_normalization(I(:,:,1),vmin,vmax);
        I(:,:,2) = dv_normalization(I(:,:,2),vmin,vmax);
        I(:,:,3) = dv_normalization(I(:,:,3),vmin,vmax);
    end
    
end
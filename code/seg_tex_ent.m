function [maskNuclei] = seg_tex_ent(I,Res,x,y)
%La hipotesis que se propuso al desarrollar este algoritmo dice que al
%procesar una imagen en esacala de grises obtenida a partir de un microscopio 
% electrónico detectara en su gran mayoría al núcleo de una célula.  
% 
% El algoritmo recibe una imagen I, una máscara Res y el largo y ancho de
%las ventanas x, y. El algoritmo consiste en segmentar una región tomando
%como referencia a la máscara Res. Si el valor del pixel en Res es de 
%un color blanco tomara toda la vecindad de pixeles e iniciara a calcular
%la propiedad de entropia, parta de esta forma obtener el núcleo. 
    
    [u,v] = size(Res);
    mEnt = zeros(u,v);
    maskNuclei = zeros(u,v);
    for i=1:u
        for j=1:v
            if  Res(i,j) == 1  || Res(i,j) == 255
                ventana = zeros(x,y);
                if i+(x-1) <= u && j+(y-1) <= v
                    ventana = I(i:i+(x-1), j:j+(y-1));
                    mEnt(i,j) = entropy(ventana);
                else
                    ventana = I(i:u, j:v);
                    mEnt(i,j) = entropy(ventana);
                end
            end
        end
    end
    
    mEnt = dv_normalization(mEnt, 0, 255);
    mEnt = uint8(mEnt);
    
    for i=1:1:u
        for j=1:1:v %160, 210  opc2: 135,200
            if mEnt(i,j) > 160 && mEnt(i,j) < 190
                maskNuclei(i,j) = 255;
            end
        end
    end
    
    


end
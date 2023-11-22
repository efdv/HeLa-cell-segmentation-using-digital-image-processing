% clear all
% clc

function cellR = dv_closeCells(I, edges_R, edges_O)


    [u,v] = size(edges_R);
    
    se = strel('diamond', 2);
    edges_R = imdilate(edges_R, se);
    se = strel('diamond', 1);
    edges_O = imerode(edges_O, se);
    

    
    edges_full = edges_R + edges_O;
  

    edges_holes =  imfill(edges_full, 'holes');
      
    bp = bwmorph(edges_holes, 'branchpoints');
    
    bw1 = bp;
    
    IR = zeros(u,v);
    
    for i=1:u
        for j=1:v
            if bw1(i,j) == 1 || bw1(i,j) == 255
                IR(i,j) = I(i,j);
            end
        end
    end
    
    umb = dv_umbrales(IR, 5); 
    
%     R = zeros(u,v);
%     for i=1:u
%         for j=1:v
%             if IR(i,j) > 130 && IR(i,j) < 160
%                 R(i,j) = 255;
%             end
%         end
%     end

    R = zeros(u,v);
    for i=1:u
        for j=1:v
            if umb(i,j) ~= 153 && umb(i,j) ~=  204
                R(i,j) = 255;
            end
        end
    end
   
    
    R =  imfill(R, 'holes');
  
    
    CC = bwconncomp(R);
    numCells = cellfun(@numel, CC.PixelIdxList);
    [x,y] = size(numCells);
    cellR = zeros(u,v);
    
    
    if numCells ~= 0
        
        x_img = u/2;
        y_img = v/2;

        for i=1:y
            obj = zeros(u,v);
            obj(CC.PixelIdxList{i}) = 255;
            [xC, yC] = centros(obj);
            dC = sqrt((xC - x_img)*(xC - x_img) + (yC - y_img)*(yC - y_img));
           
            if dC < 75
                cellR(CC.PixelIdxList{i}) = 255;
                %implementado
                se = strel('sphere', 1);
                cellR = imclose(cellR, se);
                cellR = imfill(cellR, 'holes');
                %
            end
        end
    end


  




end

function cellPaint = paintCells(celulas, nucleos)
    edges_nuc = edge(nucleos, 'canny');
    edges_cell = edge(celulas, 'canny');
    
    [u,v] = size(celulas);
    cellPaint = zeros(u,v,3);
    for i=1:u
        for j=1:v
            if celulas(i,j) == 255 || celulas(i,j) == 1 
                cellPaint(i,j,3) = 255; 
            end

            if nucleos(i,j) == 255 || nucleos(i,j) == 1
                cellPaint(i,j,3) = 0; 
                cellPaint(i,j,2) = 255; 
            end
            
            if edges_nuc(i,j) == 1 || edges_cell(i,j) == 1
                cellPaint(i,j,3) = 0; 
                cellPaint(i,j,2) = 0; 
                cellPaint(i,j,1) = 255; 
            end

        end
    end
end
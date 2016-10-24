function Shapes = determineTestSheetShapes(TS, threshold, minBlobSize)
% Shapes = determineTestSheetShapes(TS, threshold, minBlobSize)
% Function determines the shape, color and size of the images inputted.
% Only looks for colors green and red. Stores these parameters of the
% objects into the struct: Shapes.

    Shapes = struct('Shape', [], 'Color', [], 'Size', [], 'Circularity', [], 'uc', []);

    [r, g, b] = chromotography(TS, threshold);

    %%% Use to check if chromography is working. 
    %figure(1); idisp(r); 
    %figure(2); idisp(g);

    [redShapes, greenShapes, blueShapes] = getColoredBlobs(r, g, b, minBlobSize);

    for x = 1:numel(redShapes)
        circularity = redShapes(x).circularity;  
        Shapes(x).Shape = whatShape(redShapes(x).circularity);
        Shapes(x).Color = 'Red';
        Shapes(x).Size = redShapes(x).area;
        Shapes(x).Circularity = circularity;
        Shapes(x).uc = redShapes(x).uc;
    end

    for x = 1:numel(greenShapes)
        circularity = greenShapes(x).circularity;
        Shapes(x+numel(redShapes)).Shape = whatShape(greenShapes(x).circularity);
        Shapes(x+numel(redShapes)).Color = 'Green';
        Shapes(x+numel(redShapes)).Size = greenShapes(x).area;
        Shapes(x+numel(redShapes)).Circularity = circularity;
        Shapes(x+numel(redShapes)).uc = greenShapes(x).uc;
    end
    
    % Sort the shapes from left to right.
    [na, order] = sort([Shapes(:).uc],'ascend');
    Shapes = Shapes(order);
  
end
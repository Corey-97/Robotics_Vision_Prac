function matchedShapes = matchShapes(WS, Shapes, threshold, buffer, minBlobSize)
% Input Parameters:
% WS --> Work sheet picture.
% Shapes --> Structure of shape. Can be any size but should correspond to
% number of shapes on the test sheet.
% threshold --> Ammount of color considered for defining color.
% buffer --> Allowed amount of varience in the size of the test sheet
% shapes in comparison to the worksheet. 
% minBlobSize --> Minimum size of blob to be considered as a shape.
%
% Output Parameters:
% matchedShapes --> details of the matched shapes.


[r, g, b] = chromotography(WS, threshold);
redLabels = ilabel(r);
greenLabels = ilabel(g);
matches = zeros(size(redLabels));
[redShapes, greenShapes, blueShapes] = getColoredBlobs(r, g, b, minBlobSize);

for x = 1:numel(Shapes)
    %If shape looking for is red, search redShapes
    if strcmp(Shapes(x).Color, 'Red')
        for y = 1:numel(redShapes)
            if strcmp(Shapes(x).Shape, whatShape(redShapes(y).circularity))
                if (Shapes(x).Size >= (redShapes(y).area - buffer)) & (Shapes(x).Size <= (redShapes(y).area + buffer))
                    tempMatch = redLabels==(redShapes(y).label);
                    matches = matches + tempMatch;
                    matchedShapes(x) = redShapes(y);
                end
            end 
        end
    %Else If shape looking for is green, search greenShapes    
    else
        for y = 1:numel(greenShapes)
            if strcmp(Shapes(x).Shape, whatShape(greenShapes(y).circularity))
                if (Shapes(x).Size >= (greenShapes(y).area - buffer)) & (Shapes(x).Size <= (greenShapes(y).area + buffer))
                    tempMatch = greenLabels==(greenShapes(y).label);
                    matches = matches + tempMatch;
                    matchedShapes(x) = greenShapes(y);
                end
            end 
        end
    end     
end

    %%% Open a bitmap of the matched shapes and plot box with centroid on
    %%% them.
    idisp(matches);
    matchedShapes.plot_box();
    matchedShapes.plot('b*');
end
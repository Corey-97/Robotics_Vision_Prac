function [redShapes, greenShapes, blueShapes] = getColoredBlobs(r, g, b, minBlobSize)
% Function returns the blobs each corresponding to their color.
% Additionally, the parent class 1 'background' is removed from the blobs.
% All blobs with less pixels that inputted minBlobSize will not be
% returned.

    redShapes = iblobs(r, 'class', 1, 'boundary', true);
    greenShapes = iblobs(g, 'class', 1, 'boundary', true);
    blueShapes = iblobs(b, 'class', 1);
    
    if numel(redShapes) > 0
        redShapes = redShapes(redShapes.area > minBlobSize); 
    end
    if numel(greenShapes) > 0
        greenShapes = greenShapes(greenShapes.area > minBlobSize);
    end
    if numel(blueShapes) > 0
        blueShapes = blueShapes(blueShapes.area > minBlobSize);
    end
end
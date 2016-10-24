function markOtherShapes(WS, threshold, minBlobSize)
% markOtherShapes(image, threshold, minBlobSize)
%
% This function puts centroid plot points on all green and red shapes
% Additionally, a black bounding box is put on all triangles. Red shapes
% that are not triangles get red bounding boxes and green shapes that are
% not triangles get green bounding boxes.

    [r, g, b] = chromotography(WS, threshold);
    [redShapes, greenShapes, blueShapes] = getColoredBlobs(r, g, b, minBlobSize);

    idisp(r + g); % Open bitmap image.
    
    for x = 1:numel(redShapes)
        if strcmp(whatShape(redShapes(x).circularity), 'Triangle')
           redShapes(x).plot_box('b');
        else
           redShapes(x).plot_box('r');
        end
    end

    for x = 1:numel(greenShapes)
        greenShapes(x).circularity
        whatShape(greenShapes(x).circularity)
        if strcmp(whatShape(greenShapes(x).circularity), 'Triangle')
           greenShapes(x).plot_box('b');
        else
           greenShapes(x).plot_box('g');
        end
    end

    redShapes.plot('k*');
    greenShapes.plot('k*');
end
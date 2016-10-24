function bigMarkerPixelLocation = getBigBlueMarkerLocation(WS, threshold, minBlobSize)
% bigMarkerPixelLocation = getBigBlueMarkerLocation(WS, threshold,
% minBlobSize) returns the location center points of the biggest blue
% calibration marker. 
    [r, g, b] = chromotography(WS, threshold);
    [redShapes, greenShapes, blueShapes] = getColoredBlobs(r, g, b, minBlobSize);
    
    bigMarker = blueShapes(blueShapes.area == max(blueShapes.area)); 
    bigMarkerPixelLocation = [bigMarker.uc ; bigMarker.vc];
end
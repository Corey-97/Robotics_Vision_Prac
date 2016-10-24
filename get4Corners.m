function cornersMatrix = get4Corners(WS, threshold, minBlobSize)
% This function needs to be changed. Doesn't automatically find corners.
    

    [r, g, b] = chromotography(WS, threshold);
    [redShapes, greenShapes, blueShapes] = getColoredBlobs(r, g, b, minBlobSize);
    
    cornersMatrix = [blueShapes(1).uc, blueShapes(3).uc, blueShapes(8).uc, blueShapes(9).uc;
        blueShapes(1).vc, blueShapes(3).vc, blueShapes(8).vc, blueShapes(9).vc]; 
end
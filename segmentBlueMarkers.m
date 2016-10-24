function segmentBlueMarkers(WS, threshold, minBlobSize)
% Function returns a bitmap of all the blue color 'markers' in the image
% provided. Threshold is a double precision value that determines what
% magnitude of color is concidered blue.

    [r, g, b] = chromotography(WS, threshold);

    [redShapes, greenShapes, blueShapes] = getColoredBlobs(r, g, b, minBlobSize);

    idisp(b);
    blueShapes.plot_box('b');
    blueShapes.plot('b*');
end
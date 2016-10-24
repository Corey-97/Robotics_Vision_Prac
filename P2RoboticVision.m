%% Prac 2 (Robotic Vision)
close all; clear all; clc;

%% Load images
%This section may have addition revision as to automatically pull the
%images from a server. However, at the moments, reads only images on the
%local machine. This will change depending on time constraints.
%
%Images to be loaded in as double precision. Not 8uint!

TS = iread('P2TS.png', 'double'); % Load the picture of the TestSheet into TS
WS = iread('P2WS.png', 'double'); % Load the picture of the WorkSheet into TS

%% Determine parameters of Test Sheet shapes.
% Parameters to determine: Shape, Color, Size.

threshold = 0.4;
minBlobSize = 150;
Shapes = determineTestSheetShapes(TS, threshold, minBlobSize);
for x = 1:numel(Shapes)
    display(sprintf('Shape %d:', x));
    display(Shapes(x).Shape);
    display(Shapes(x).Color);
    display(sprintf('%d Pixels', Shapes(x).Size));
    display(sprintf('\n'));
end

%% Segment Blue Markers
% Segmentation requires bit map with box and centroid on all circles.

threshold = 0.4;
minBlobSize = 100;
segmentBlueMarkers(WS, threshold, minBlobSize);
pause();

%% Segment Other Shapes
% Segment requires bitmap with all centroids marked. Bounding box on all
% triangle. With different colored bounding box on green objects.

threshold = 0.4;
minBlobSize = 100;
markOtherShapes(WS, threshold, minBlobSize);
pause();

%% Match Test Sheet Shapes with Work Sheet
% Matchs the shapes and then plots them on there own individual bitmap.

threshold = 0.4;
buffer = 200;
minBobSize = 100;
matchedShapesDetails = matchShapes(WS, Shapes, threshold, buffer, minBlobSize);
pause();

%% Compute Homography
%

%%% Obtain the points in the picture that will be needed. Either for
%%% obtaining the homography or as a point the robot needs to move to.
cornerLocations = [20, 380, 20, 380; 380, 380, 20, 20];
cornerPixelLocations = get4Corners(WS, threshold, minBlobSize);
bigMarkerPixelLocation = getBigBlueMarkerLocation(WS, threshold, minBlobSize);
matchedShapesPixelLocations = [matchedShapesDetails(1).uc, matchedShapesDetails(2).uc, matchedShapesDetails(3).uc;
    matchedShapesDetails(1).vc, matchedShapesDetails(2).vc, matchedShapesDetails(3).vc];

%%% Compute Homograpghy and use the inverse to find worksheet cood.
workSheetHomography = homography(cornerPixelLocations, cornerLocations);
startingPoint = round(homtrans(workSheetHomography, bigMarkerPixelLocation));
points = round(homtrans(workSheetHomography, matchedShapesPixelLocations));

%%% Display coordinates in new windom and in mm.
clc;
display('Staring Point: ');
display(sprintf('x = %d mm', startingPoint(1)));
display(sprintf('y = %d mm \n', startingPoint(2)));

display('Workspace Point Coordinates:');
display('Point 1: ');
display(sprintf('x = %d mm', points(1, 1))); display(sprintf('y = %d mm', points(2, 1)));
display('Point 2: ');
display(sprintf('x = %d mm', points(1, 2))); display(sprintf('y = %d mm', points(2, 2)));
display('Point 3: ');
display(sprintf('x = %d mm', points(1, 3))); display(sprintf('y = %d mm', points(2, 3)));

close all;
%% Call Robot to move between points
% Uses function from Prac 1.

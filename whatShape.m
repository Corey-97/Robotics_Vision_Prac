function shapeType = whatShape(circularity)
% Returns the shape name of the object in regards to the object
% circularity. Values will change depending on camera.

    if circularity > 0.91
        shapeType = 'Circle';
    elseif circularity >= 0.77 && circularity <= 0.91
        shapeType = 'Square';
    else
        shapeType = 'Triangle';
    end
end
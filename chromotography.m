function [r, g, b] = chromotography(image, threshold)
    % Function seperates each color and returns a bitmap of the color with
    % the same dimensions as the input image.
    % As of 16107: This function now cleans images before returning them.
    
    R = image(:, :, 1); G = image(:, :, 2); B = image(:, :, 3); 
    Y = R + G + B;

    r = R ./ Y; r = r >= threshold;
    g = G ./ Y; g = g >= threshold;
    b = B ./ Y; b = b >= threshold;
    
    r = iclose(r, ones(3, 3));
    g = iclose(g, ones(3, 3));  
    b = iclose(b, ones(3, 3));
end
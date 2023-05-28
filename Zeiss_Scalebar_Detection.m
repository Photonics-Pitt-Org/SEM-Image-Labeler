function [ScaleBar_Pixels, ScaleBar_Locsx, ScaleBar_Locsy, Length] = Zeiss_Scalebar_Detection(Image)
    %% Scalebar Detection 
    image_start = imread('lib/zeiss/distance_start.tif');
    image_end = imread('lib/zeiss/distance_end.tif');
    size_image = size(Image);
    size_image_start = size(image_start);
    size_image_end = size(image_end);
    
    mat_start = Find_Image_in_Image(Image, image_start) + size_image_start(1:2) / 2;
    mat_end = Find_Image_in_Image(Image, image_end) + size_image_end(1:2) / 2;

    ScaleBar_Pixels = abs(mat_start(2) - mat_end(2));
    ScaleBar_Locsx = [mat_start(2), mat_end(2)];
    ScaleBar_Locsy = [mat_start(1), mat_end(1)];
    
    [Text] = Text_Detection(Image(1:max(ScaleBar_Locsy), min(ScaleBar_Locsx):max(ScaleBar_Locsx)), "zeiss", ".tif");
    
    if contains(Text, "µm")
        Length = str2double(strrep(Text, "µm", ""));
    elseif contains(Text, "nm")
        Length = str2double(strrep(Text, "nm", "")) / 1000;
    else
        Length = "";
    end
end


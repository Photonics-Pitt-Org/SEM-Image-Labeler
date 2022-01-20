function [Text] = Scale_Text_Detection_Zeiss(Image)
    Text = "";
    size_image = size(Image);
    path = 'lib\';
    characters = [
        "0" "0.tif";
        "1" "1.tif";
        "2" "2.tif";
        "3" "3.tif";
        "4" "4.tif";
        "5" "5.tif";
        "6" "6.tif";
        "7" "7.tif";
        "8" "8.tif";
        "9" "9.tif";
        "." "dot.tif";
        "=" "equal.tif";
        "µ" "micro.tif";
        "m" "m.tif";
        "n" "n.tif"
    ];
    size_characters = size(characters);
    found_at = [-1];
    found = [-1];

    for i = 1:size_characters(1)
        value = characters(i, 1);
        text_image = strcat(path, characters(i, 2));
        position = Find_Image_in_Image(Image, imread(text_image));
        
        if position(1) == -1
            continue
        end
        
        size_position = size(position);
        for j = 1:size_position(1)
            lateral_position = position(j, 1) * size_image(2) + position(j, 2);
            if found(1) == -1
                found_at = [lateral_position];
                found = [i];
            else
                found_at = [found_at lateral_position];
                found = [found i];
            end
        end
    end
    [~, sortIdx] = sort(found_at);
    
    sorted_text_index = found(sortIdx);
    
    for i = 1:length(sorted_text_index)
        Text = strcat(Text, characters(sorted_text_index(i), 1));
    end
end



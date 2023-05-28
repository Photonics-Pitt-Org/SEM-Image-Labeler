function [Text] = Text_Detection(Image, Folder, Extension)
    Text = "";
    size_image = size(Image);
    path = strcat('lib\', Folder, '\');
    characters = [
        "0" strcat("0", Extension);
        "1" strcat("1", Extension);
        "2" strcat("2", Extension);
        "3" strcat("3", Extension);
        "4" strcat("4", Extension);
        "5" strcat("5", Extension);
        "6" strcat("6", Extension);
        "7" strcat("7", Extension);
        "8" strcat("8", Extension);
        "9" strcat("9", Extension);
        "." strcat("dot", Extension);
        "=" strcat("equal", Extension);
        "µ" strcat("micro", Extension);
        "m" strcat("m", Extension);
        "n" strcat("n", Extension)
    ];
    size_characters = size(characters);
    found_at = [-1];
    found = [-1];

    for i = 1:size_characters(1)
        value = characters(i, 1);
        text_image = strcat(path, characters(i, 2));
        
        if ~isfile(text_image)
            continue;
        end

        position = Find_Image_in_Image(Image, imread(text_image));
        
        if position(1) == -1
            continue;
        end
        
        if found(1) == -1
            found_at = [position(2)];
            found = [i];
        else
            found_at = [found_at position(2)];
            found = [found i];
        end
    end
    [~, sortIdx] = sort(found_at);
    
    sorted_text_index = found(sortIdx);
    
    for i = 1:length(sorted_text_index)
        Text = strcat(Text, characters(sorted_text_index(i), 1));
    end
end



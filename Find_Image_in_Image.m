function [coordinates] = Find_Image_in_Image(MainImage, Search)
    coordinates = [-1 -1];
    [r, c] = size(MainImage);
    [rc, cc] = size(Search);
    d_MainImage = double(MainImage);
    d_Search = double(Search);
    
    for i = 1:(r - rc - 5)
        for j = 1:(c - cc - 5)
            Testmat = d_MainImage(i:(i + rc - 1), j:(j + cc - 1));
            if isequal((d_Search), (Testmat))
                if coordinates(1) == -1
                    coordinates = [i j];
                else
                    coordinates = [coordinates; i j];
                end
            end
        end
    end
end


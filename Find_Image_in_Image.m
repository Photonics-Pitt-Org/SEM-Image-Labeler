function [coordinates] = Find_Image_in_Image(MainImage, Search)
    coordinates = [-1 -1];
    [r, c] = size(MainImage);
    [rc, cc] = size(Search);
    d_MainImage = double(MainImage);
    d_Search = double(Search);
    
    is_rgb = size(size(d_MainImage));
    if (is_rgb(2) == 3)
        d_MainImage = d_MainImage(:, :, 1);
    end
    is_rgb = size(size(d_Search));
    if (is_rgb(2) == 3)
        d_Search = d_Search(:, :, 1);
    end
    
    correlationOutput = normxcorr2(d_Search, d_MainImage);
    [maxCorrValue, maxIndex] = max(abs(correlationOutput(:)));
    [yPeak, xPeak] = ind2sub(size(correlationOutput),maxIndex(1));
    if (maxCorrValue > 0.99)
        coordinates = [floor(yPeak-size(d_Search,1)) floor(xPeak-size(d_Search,2))];
    else
        coordinates = [-1, -1];
    end
    
    % for i = 1:(r - rc)
    %     for j = 1:(c - cc)
    %         Testmat = d_MainImage(i:(i + rc - 1), j:(j + cc - 1));
    %         if isequal((d_Search), (Testmat))
    %             if coordinates(1) == -1
    %                 coordinates = [i j];
    %             else
    %                 coordinates = [coordinates; i j];
    %             end
    %         end
    %     end
    % end
end


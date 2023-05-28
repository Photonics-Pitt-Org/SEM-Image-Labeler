function [ScaleBar_Pixels,ScaleBar_Locsx, ScaleBar_Locsy] = Jeol_Scalebar_Detection(Image)
%% Scalebar Image Definition 
Scale_Image=[
    0 0 0 0 0; 
    0 1 1 1 0;
    0 1 0 1 0;
    0 1 1 1 0;
    0 0 0 0 0
]; %% The format of the scale bar markers

%% Scalebar Detection 

[r, c] = size(Image);
[rc, cc] = size(Scale_Image);
count = 0;
New_Im = double(Image)/255;
mat = [];

for i = 1:(r-rc-5)
    for j = 1:(c-cc-5)
        Testmat=New_Im(i:(i+rc-1), j:(j+cc-1));
        %imshow(Testmat)
        if isequal((Scale_Image), (Testmat))
            count = count+1;
            mat(count, :)=[i j];
        end
    end
end

if isempty(mat)
    Scale_Image=[
        0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0;
        0 0 1 1 1 1 1 1 1 0 0;
        0 0 1 1 1 1 1 1 1 0 0;
        0 0 1 1 0 0 0 1 1 0 0;
        0 0 1 1 0 0 0 1 1 0 0;
        0 0 1 1 0 0 0 1 1 0 0;
        0 0 1 1 1 1 1 1 1 0 0;
        0 0 1 1 1 1 1 1 1 0 0;
        0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0
    ]; %% The format of the scale bar markers

    %% Scalebar Detection 
    
    [r, c] = size(Image);
    [rc, cc] = size(Scale_Image);
    count = 0;
    New_Im = double(Image)/255;
    for i = 1:(r-rc-11)
        for j = 1:(c-cc-11)
            Testmat = New_Im(i:(i+rc-1), j:(j+cc-1));
            %imshow(Testmat)
            if isequal((Scale_Image), (Testmat))
                count = count+1;
                mat(count, :) = [i j];
            end
        end
    end
end

ScaleBar_Pixels = max(mat(:,2))-min(mat(:,2));
ScaleBar_Locsx = [max(mat(:,2))+2 min(mat(:,2))+2];
ScaleBar_Locsy = [max(mat(:,1)) min(mat(:,1))];
end


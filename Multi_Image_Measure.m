function [] = Multi_Image_Measure(Mode, Instrument, Save, ImagePath, ImageName, Scale)
    %% Open & Load the Image - Select the images one by one, could modify to run in a loop if multiple images are needed  
    Image = imread(strcat(ImagePath, ImageName));

    if Mode == 2 % This part selects which mode to run, find the scalebar or re-measure it if custom mode is selected
        [ScaleBar_Pixels] = Manual_Mode_Calibration(Image); 
    elseif or(Mode==1, Mode==0)
        % Detect Scalebar
        if Instrument==1
            [ScaleBar_Pixels, ScaleBar_Locsx, ScaleBar_Locsy] = Scalebar_Detection_Merlin(Image);
        elseif Instrument==2
            [ScaleBar_Pixels, ScaleBar_Locsx, ScaleBar_Locsy] = Scalebar_Detection_Jeol(Image);
        elseif Instrument==3
            [ScaleBar_Pixels, ScaleBar_Locsx, ScaleBar_Locsy, ScaleBar] = Scalebar_Detection_Zeiss(Image);
        end
    end
    if or(Mode == 1, Mode == 2)
        ScaleBar = Scale; % Scale bar size in microns
    end
    %% Select the Points to Measure - Select the points using mouse and zoom in (I) and out (O) as needed
    [X, Y] = Choose_Points_on_Image(Image, ScaleBar);

    imshow(Image)
    
    text(20, 20, ['Scalebar: ' num2str(ScaleBar) '\mum'], 'FontSize', 12, 'Color', 'r');
    x_sb = [ScaleBar_Locsx(1) ScaleBar_Locsx(2)];
    y_sb = [ScaleBar_Locsy(1) ScaleBar_Locsy(2)];
    pl = line(x_sb, y_sb, 'LineWidth', 3);
    pl.Color = 'green';
    label_Lines = [];
    
    for i=1:2:length(X)
        if i < length(X)
            count = (i - 1) / 2 + 1;
            line([X(i) X(i+1)], [Y(i) Y(i+1)], 'LineWidth', 3);
            line_length = sqrt((X(i) - X(i+1))^2 + (Y(i) - Y(i+1))^2);
            line_length_microns = round(line_length * (ScaleBar / ScaleBar_Pixels), 6);
            label_Lines{count} = ['Line', ' ', num2str(count), ': ', num2str(line_length_microns), ' ', '\mum' ];
            text(X(i), Y(i), strcat(num2str(count), ": ", num2str(line_length_microns), "\mum") , 'FontSize', 10, 'Color', 'r');
        end
    end
    if length(label_Lines) > 0
        legend(label_Lines);
    end

    %% Saving 
    if Save == 1
        saveas(gcf, strcat(ImagePath, 'Z_', ImageName(1:length(ImageName) - 4)), 'png')
%         saveas(gcf, strcat(ImagePath, 'Z_', ImageName(1:length(ImageName) - 4)), 'tiffn')
    end
    close all

end


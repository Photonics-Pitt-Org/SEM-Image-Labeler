function [X, Y]= Choose_Points_on_Image(Image, Scale, Coordinate_Scalebar)
    X = []; Y = [];
    imshow(Image);
    size_image = size(Image);
    title('Measure Features: Click for point A, Click again for point B (For Zoom: z (+), c (-), x (reset))');
    text(20, 20, ['Scalebar: ' num2str(Scale) '\mum'], 'FontSize', 12, 'Color', 'r');
    line(Coordinate_Scalebar(1, :), Coordinate_Scalebar(2, :), 'LineWidth', 3, 'Color', 'red');
    
    while 0<1
        [x, y, b] = ginput(1);
        if isempty(b)
            break;
        elseif or(b == '-', b == 'c')
            ax = axis;
            width = ax(2) - ax(1);
            height = ax(4) - ax(3);
            axis([x-width/2 x+width/2 y-height/2 y+height/2]);
            zoom(1/2);
        elseif or(b == '+', b == 'z')
            ax = axis;
            width = ax(2) - ax(1);
            height = ax(4) - ax(3);
            axis([x-width/2 x+width/2 y-height/2 y+height/2]);
            zoom(2);
        elseif b == 'x'
            axis([0 size_image(2) 0 size_image(1)]);
            zoom(1);
        elseif b == 1
            X = [X; x];
            Y = [Y; y];
        end
        
        for i=1:2:length(X)
            if i < length(X)
                line([X(i) X(i+1)], [Y(i) Y(i+1)], 'LineWidth', 3);
            end
        end
    end
end
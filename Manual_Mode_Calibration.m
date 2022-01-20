function [ScaleBar_Pixels,ScaleBar_Locsx,ScaleBar_Locsy] = Manual_Mode_Calibration(Image)
figure 
    imshow(Image)
    title('MANUAL MODE: Click on the two edges of the scalebar for calibration') 
    dim = [0.27 0.4 0.8 0.5];
    str='Remember: I to Zoom In , O to Zoom Out';   
    a=annotation('textbox',dim,'String',str,'FitBoxToText','on');
    a.Color='red';
    a.FontSize =16;
    [locx, locy] = My_zoom();
    ScaleBar_Pixels = (locx(2)-locx(1));
    close all
    
    ScaleBar_Locsx=locx;
    ScaleBar_Locsy=locy;
end


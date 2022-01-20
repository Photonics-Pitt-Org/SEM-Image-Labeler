clear, close all, clc
%% Important: Are you using the Merlin, the Cleanroom SEM or other Instrument? ...
% Mode=0 - BETA - Automatic detection of scalebar and text - 
% Mode 1 - Automatic detection of scalebar but not text - enter scale value manually
% Mode 2 - Manual input of both scalebar and text

Mode        = 0;
Instrument  = 3; % Please select the your SEM: Merlin=1, Zeiss SEM = 2 if other no effect
Scale       = 1; % In Microns - if Mode 1 or 2 enter the scalebar size - ie How many microns is the scalebar? (makes no difference for mode 0)
Save        = 1; % Do you want to save the image after you run the script? 0 for NO - 1 for Yes
%% Run Image Loop
[ImageNames, path] = uigetfile('*.*','MultiSelect','on');
if iscell(ImageNames)
    for i = 1:length(ImageNames)
        Multi_Image_Measure(Mode, Instrument, Save, path, ImageNames{i}, Scale);
    end
else
    Multi_Image_Measure(Mode, Instrument, Save, path, ImageNames, Scale);
end

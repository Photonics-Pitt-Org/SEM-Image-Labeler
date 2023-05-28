function [ScaleBar_Pixels,ScaleBar_Locsx, ScaleBar_Locsy] = Merlin_Scalebar_Detection(Image)
%% Scalebar Image Definition 
Scale_Image_1=zeros(14);
Scale_Image_1(:,14)=ones(14,1);
Scale_Image_1(7,:)=ones(1,14);

Scale_Image_2=zeros(14);
Scale_Image_2(:,1)=ones(14,1);
Scale_Image_2(7,:)=ones(1,14);

%% Scalebar Detection 

[r, c]=size(Image);
[rc, cc]=size(Scale_Image_1);
count=0;
New_Im=double(Image)/255;
for i=1:(r-rc-5)
for j=1:(c-cc-5)
    Testmat=New_Im(i:(i+rc-1),j:(j+cc-1));
     %imshow(Testmat)
    if isequal((Scale_Image_1),(Testmat))
        count=count+1;
        mat(count,:)=[i j];
    end
    if isequal((Scale_Image_2),(Testmat))
        count=count+1;
        mat(count,:)=[i j];
    end

end
end   
ScaleBar_Pixels=max(mat(:,2))+13-min(mat(:,2));
ScaleBar_Locsx=[max(mat(:,2))+13 min(mat(:,2))];
ScaleBar_Locsy=[max(mat(:,1)) min(mat(:,1))];
end


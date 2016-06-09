function main()
ch=input('You want to train press 1 else 2');
if ch==1
for i=1:8
diry=[pwd '\dataset\' num2str(i)];
   disp(' features Extraction.....');
   feature1=training(diry);
   if i==1
       out=feature1;
       group=ones(size(feature1,1),1)*i;
   else
       group1=ones(size(feature1,1),1)*i;
       group=[group;group1];
       out=[out;feature1];
   end
end 
save training;
else
    load('training.mat');
end
%%
[File_Name, Path_Name] = uigetfile('*.*','Select The Image');
       I = imread([Path_Name,File_Name]);
       subplot(1,3,1),imshow(I);
       title('Original Leaf Image');
      if size(I,3)==3 
           I=rgb2gray(I); 
       end
     I = histeq(I);
       
subplot(1,3,2),imshow(I);
title('Enhanced Leaf Image');

%%
level=graythresh(I);
BW_I = ~im2bw(I,level);

% BW_I_selected = im2bw(BW_I);

% white_pixels_I_selected = sum(BW_I_selected(:) == 1);

se = strel('disk',5);

closeBW = imdilate(BW_I,se);
I=uint8(closeBW.*double(I));
 subplot(1,3,3),imshow(I);
title('Segmented Image');

%%
      GLCM2 = graycomatrix(I ,'Offset',[2 0;0 2]);
      out1 = GLCM_Features(GLCM2,0);
      feature(1,:)=out1.maxpr;
      feature(2,:)=out1.energ;
      feature(3,:)=out1.entro;
      feature(4,:)=out1.contr;
      feature(5,:)=out1.dissi;
      feature(6,:)=out1.homom;  
      feature(7,:)=out1.idmnc;
  feature

end

function dataset=training(directory)

       file=dir(directory);
for i1=3:length(file)
    
       filename=[directory '\' file(i1).name];
       I=imread(filename);
       if size(I,3)==3 
           I=rgb2gray(I); 
       end
        I = histeq(I);
       

%%
level=graythresh(I);
BW_I =~ im2bw(I,level);

% BW_I_selected = im2bw(BW_I);
% 
% white_pixels_I_selected = sum(BW_I_selected(:) == 1);

se = strel('disk',5);

closeBW = imdilate(BW_I,se);
I=uint8(closeBW.*double(I));
%  figure,imshow();
% title('Binary of Clustered Image');

%%
      GLCM2 = graycomatrix(I ,'Offset',[2 0;0 2]);
      out = GLCM_Features(GLCM2,0);
      feature(1,:)=out.maxpr;
      feature(2,:)=out.energ;
      feature(3,:)=out.entro;
      feature(4,:)=out.contr;
      feature(5,:)=out.dissi;
      feature(6,:)=out.homom;  
      feature(7,:)=out.idmnc;
%   feature


 
 dataset(i1-2,:)=feature(:);
end    
end




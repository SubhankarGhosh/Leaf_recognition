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
closeBW=bwareaopen(closeBW,1000);
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




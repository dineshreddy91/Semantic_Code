clc;
clear all;
close all;
%for i=7:15
dir_files= '/home/dineshn/new_code/dataset/';
dataset=5;
Imgs = dir([dir_files 'Left/' num2str(dataset) '/*']);
%matlabpool

%% check flow
%compute_flow(dataset);
%sf
%% read flow file
%flow_clustering(dataset);
%dfd
%% depth 
%depth_only(dataset);

%sfd
%% texton potentials
for loop=3:size(Imgs,1)
%loop=5;
[pathstr,name,ext]=fileparts(Imgs(loop).name);
image=imread([dir_files 'Left_png/' num2str(dataset) '/' name '.png']) ;
[potentials]=read_textonpotentials([dir_files 'textonboost/' num2str(dataset) '/' name '.dns']);


%% potentials from the video
%[potentials]=potentials_from_video(dataset)


%% write the new potentials
write_textonpotential([dir_files 'ours/' num2str(dataset) '/' name '.dns'],potentials,1242,375,11);
%[potentials]=read_textonpotentials([dir_files 'ours/' num2str(dataset) '/' name '.dns']);

%% get the max label
% labelled_image=[];
% for i=1:size(image,1)
%     for j=1:size(image,2)
%         h=squeeze(potentials(i,j,:));
%         [max_value,label]=min(-h);
%         labelled_image(i,j)=label;
%     end
% end


%% dense crf
cd /home/dineshn/new_code/semantic_codes/densecrf/examples
imwrite(image,'1.ppm');
%system(['make']);
system(['./dense_inference 1.ppm '  dir_files 'textonboost/' num2str(dataset) '/' name '.dns ' '2.ppm']);
array=csvread('labelled_image.csv');
array(:,:)=array(:,:)+1;
cd ../..
labelled_image_dense = reshape(array,[size(image,2) size(image,1)])';
[ labelled_image_color_dense ] = label_to_color( labelled_image_dense );



%% convert to color image
% [ labelled_image_color ] = label_to_color( labelled_image );
% imshow(labelled_image_color);
% ginput(1);
end
% subplot(2,2,1);
% imshow(image);
% subplot(2,2,2);
% imshow(labelled_image_color_dense);
% subplot(2,2,3);
% imshow(image_gt);
% subplot(2,2,4);
% imshow(image_ale);
%end











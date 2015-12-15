clear all;
close all;
clc;
%% evaluation script

%% read  ground truth segmentation
count=0;
for i=1:15
dir_files= '/home/dineshn/new_code/dataset/';
dataset=i;
Imgs = dir([dir_files 'Left/' num2str(dataset) '/*']);

for loop=3:size(Imgs,1)
    [pathstr,name,ext]=fileparts(Imgs(loop).name);
    file_name=[dir_files 'Groundtruth/' num2str(dataset) '/' name '.png'];
if exist(file_name, 'file') == 2
image_gt=imread(file_name) ;
file_name
[labelled_image_gt] = color_to_label(image_gt);

%% read ALE
 image_ale=imread([dir_files 'ALE_results/' num2str(dataset) '/' name '.png']) ;
 [labelled_image_ale] = color_to_label(image_ale);

%% compare the algorithm with GT

%results_ale=compare_the_results(labelled_image_gt,labelled_image_ale)
count=count+1
results_final(count,:)=compare_the_results(labelled_image_gt,labelled_image_ale)';

%ginput(1);
end
end
end


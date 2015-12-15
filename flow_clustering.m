function flow_clustering(i)
dir_files= '/home/dineshn/new_code/dataset/';
dataset=i;
Imgs = dir([dir_files 'flow/' num2str(dataset) '/*']);

%% flow

for loop=3:size(Imgs,1)-1
    [pathstr,name,ext]=fileparts(Imgs(loop).name);
    flow_fileName_f=[dir_files 'flow/' num2str(dataset) '/' name '.flo'];
    ab=readFlowFile(flow_fileName_f);
    %% save flow as image
    flow_img=[dir_files 'flow_img/' num2str(dataset) '/' name '.png'];
    img=flowToColor(ab);
    imwrite(img,flow_img);
    display(flow_img);
    %% clustering
%    nrows = size(ab,1);
%    ncols = size(ab,2);
%    ab = reshape(ab,nrows*ncols,2);
%    flow_final=flow_f(:,:,1)+flow_f(:,:,2);
%    [cluster_idx, cluster_center] = kmeans(ab,10);
%    pixel_labels = reshape(cluster_idx,nrows,ncols);
%    flow_cluster=[dir_files 'kmeans/' num2str(dataset) '/' name '.png'];
%    RGB = label2rgb(pixel_labels);
%    imwrite(RGB,flow_cluster);
end
end
function []= depth_for_stationary(num)
tic;
dir_files= '/home/dineshn/new_code/dataset/';
dataset=num;
K=[718.856 0 607.1928;0 718.856 185.2157; 0 0 1];
baselength=0.54;
Imgs = dir([dir_files 'Left_png/' num2str(dataset) '/*']);
addpath('mexopencv');
addpath('libviso2');
for loop=3:size(Imgs,1)
   [pathstr,name,ext]=fileparts(Imgs(loop).name);
    display([num2str(loop) ' out of ' num2str(size(Imgs,1))]);
    fileName=[dir_files 'Left_png/' num2str(dataset) '/' Imgs(loop).name];
    im_l1=imread(fileName);
    im_r1=imread([dir_files 'ALE_results/' num2str(dataset) '/' Imgs(loop).name]);
    im_ale=imread([dir_files 'Right/' num2str(dataset) '/' Imgs(loop).name]);
    im_motion=imread([dir_files 'motion/' num2str(dataset) '/' name '.jpg']);
    system(['./spsstereo/spsstereo ' dir_files 'Left_png/' num2str(dataset) '/' Imgs(loop).name ' ' dir_files 'Right/' num2str(dataset) '/' Imgs(loop).name]);
 %   bm=cv.StereoSGBM('MinDisparity',0,'SADWindowSize',5,'P1',50,'P2',800,'UniquenessRatio',0,'PreFilterCap',15,'SpeckleWindowSize',100,'SpeckleRange',32,'FullDP',1);
%    d_second=double((bm.compute(im_l1,im_r1))/16);
    d_first=uint16(imread(['./' name '_left_disparity.png']));
    system(['rm ./' name '_left_disparity.png ']);
    system(['rm ./' name '_boundary.png ']);
    system(['rm ./' name '_segment.png ']);
    system(['rm ./' name '_label.txt ']);
    system(['rm ./' name '_plane.txt ']);
    %imshow(d_first);
        for p_y=1:size(d_first,2)
            for p_x=1:size(d_first,1)
               d_average=d_first(p_x,p_y);
               if d_average>35500 
                  finale_image(p_x,p_y)=0;
                  d_first(p_x,p_y)=0;
               elseif im_ale(p_x,p_y,1)==128 && im_ale(p_x,p_y,2)==128 && im_ale(p_x,p_y,3)==128 % remove sky from stationary
                      finale_image(p_x,p_y)=0;
                      d_first(p_x,p_y)=0;
               elseif im_motion(p_x,p_y)>0 % remove moving pixels from reconstruction
                      finale_image(p_x,p_y)=0;
                      d_first(p_x,p_y)=0;
               else
               pw=d_first(p_x,p_y);
              
               if pw<2580 %&& im_motion(p_x,p_y)>10
                  
                  d_first(p_x,p_y)=0;
               end
                   finale_image(p_x,p_y)=d_first(p_x,p_y);
                   
               end
               end
                   
        end
        

      finale_image=uint16(finale_image);
%     imwrite(finale_image,[dir_files 'Depth_spss_I/' num2str(dataset) '/' sprintf('%04d',loop-3) '.pgm'])
     imwrite(im_l1,[dir_files 'Depth_spss_I/' num2str(dataset) '/' sprintf('%04d',loop-3) '.ppm'])
    imwrite(d_first,[dir_files 'Depth_spss_I/' num2str(dataset) '/' sprintf('%04d',loop-3) '.pgm'])

    end
end

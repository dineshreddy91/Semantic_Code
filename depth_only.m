function []= depth_only(num)
tic;
dir_files= '/home/dineshn/new_code/dataset/';
dataset=num;
K=[718.856 0 607.1928;0 718.856 185.2157; 0 0 1];
baselength=0.54;
Imgs = dir([dir_files 'Left_png/' num2str(dataset) '/*']);
addpath('mexopencv');
addpath('libviso2');
parfor loop=3:size(Imgs,1)
    if(num==14)
        loop1 = loop+15;
    else
        loop1=loop;
    end
    [pathstr,name,ext]=fileparts(Imgs(loop1).name);
    display([num2str(loop1) ' out of ' num2str(size(Imgs,1))]);
    fileName=[dir_files 'Left_png/' num2str(dataset) '/' Imgs(loop1).name];
    if(num~=14)
        im_l1=imread(fileName);
        im_r1=imread([dir_files 'Right/' num2str(dataset) '/' Imgs(loop1).name]);
        system(['./spsstereo/spsstereo ' dir_files 'Left_png/' num2str(dataset) '/' Imgs(loop).name ' ' dir_files 'Right/' num2str(dataset) '/' Imgs(loop).name]);
    else
        im_l1=imread([dir_files 'Left_png/14' '/left_' num2str(loop1) '.png' ]);
        im_r1=imread([dir_files 'Right/14' '/right_' num2str(loop1) '.png' ]);
        system(['./spsstereo/spsstereo ' dir_files 'Left_png/' num2str(dataset) '/' 'left_' num2str(loop) '.png ' dir_files 'Right/' num2str(dataset) '/' 'right_' num2str(loop) '.png ' ]);
    end
   
%     bm=cv.StereoSGBM('MinDisparity',0,'SADWindowSize',5,'P1',50,'P2',800,'UniquenessRatio',0,'PreFilterCap',15,'SpeckleWindowSize',100,'SpeckleRange',32,'FullDP',1);
%     d_first=double((bm.compute(im_l1,im_r1))/16);
   d_first=uint16(imread(['./' name '_left_disparity.png']));
    system(['rm ./' name '_left_disparity.png ']);
    system(['rm ./' name '_boundary.png ']);
    system(['rm ./' name '_segment.png ']);
    system(['rm ./' name '_label.txt ']);
    system(['rm ./' name '_plane.txt ']);
    %imshow(d_first);
        for p_y=1:size(d_first,2)
            for p_x=1:size(d_first,1)
               pw=d_first(p_x,p_y);
               Z=double(K(1,1)*baselength);
               if pw<2580 %&& im_motion(p_x,p_y)>10
                  finale_image(p_x,p_y)=31999;
                  d_first(p_x,p_y)=0;
               else
                  finale_image(p_x,p_y)=Z*256*1000/pw;
               end
               if (finale_image(p_x,p_y)>31999 || finale_image(p_x,p_y)< 2000)
                   finale_image(p_x,p_y)=31999;
               end
             end
        end


    finale_image=uint16(finale_image);
%     imwrite(finale_image,[dir_files 'Depth_spss_I/' num2str(dataset) '/' sprintf('%04d',loop-3) '.pgm'])
     imwrite(im_l1,[dir_files 'Depth_spss_I/' num2str(dataset) '/' sprintf('%04d',loop-3) '.ppm'])
    imwrite(d_first,[dir_files 'Depth_spss_I/' num2str(dataset) '/' sprintf('%04d',loop-3) '.pgm'])

end

end

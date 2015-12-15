clear all;
close all;
clc;

seq=16;
%% depth computation
%depth_only(seq)
%depth_for_stationary(seq)

%% 
%system('../test/InfiniTAM/InfiniTAM/build/make');
system(['../test/InfiniTAM/InfiniTAM/build/InfiniTAM  ../dataset/Depth_spss_I/14/calib.txt ../dataset/Depth_spss_I/16/' num2str(seq)  '/%00i.ppm ../dataset/Depth_spss_I/' num2str(seq) '/%03i.pgm']);
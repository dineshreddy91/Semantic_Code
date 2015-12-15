function [ results ] = compare_the_results( labelled_image_gt,labelled_image)

 for j=1:10%max(labelled_image_gt(:))
  points_gt=find(labelled_image_gt==j);
  points_labelled=find(labelled_image==j);
  true_positive = size(intersect(points_gt,points_labelled),1);
    if true_positive >10
    false_positive=size(points_gt,1)-true_positive;
    false_negative=size(points_labelled,1)-true_positive;
    results(j)=true_positive*100/(true_positive+false_negative+false_positive);
    else
    results(j)=1000;
    end
 end
end


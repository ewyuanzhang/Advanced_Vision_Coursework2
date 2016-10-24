# Advanced_Vision_Coursework2
The 2rd coursework of [Advanced Vision](http://www.inf.ed.ac.uk/teaching/courses/av/) (UoE, 2016)

## Task Description
In brief, the task is to rebuild a 3D scene by 16 views captured by a Kinect depth sensor. Objects in the scene are a 9-plane-cube surrounded by 3 spheres. Subtasks are: 

1. Extract and remove the ground plane from the image data
2. Extract and describe the 3 spheres
3. Use the 3 spheres to register and fuse the XYZ data from all images
4. Extract the 9 planes from the data
5. Build as complete a 3D model as possible and characterise the surfaces.

Details can be found in [prac21516.pdf](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/prac21516.pdf). 

## Data

The data of 16 views can be downloaded from http://homepages.inf.ed.ac.uk/rbf/AVDATA/AV216DATA/av_pcl.mat .

## Files
- [functions](https://github.com/getchaz/Advanced_Vision_Coursework2/tree/master/functions)/*.m: Functions used in this coursework. [plotpcl.m](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/functions/plotpcl.m), [sphereFit.m](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/functions/sphereFit.m) and [sphereFit_test.m](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/functions/sphereFit_test.m) are provided by the lecturer. 
- [ass_2_f1.m](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/ass_2_f1.m): Script of background extraction
- [ass_2_f2.m](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/ass_2_f2.m): Script of registration
- [ass_2_f3.m](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/ass_2_f3.m): Script of object plane extraction
- [ass_2_f4.m](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/ass_2_f4.m): Script of object model building
- [prac21516.pdf](https://github.com/getchaz/Advanced_Vision_Coursework2/blob/master/prac21516.pdf): Description of the coursework

## Authors
- Yuan Zhang - zhyuan0702@gmail.com
- Alexandru Cojocaru - cojocaru.alex3010@gmail.com

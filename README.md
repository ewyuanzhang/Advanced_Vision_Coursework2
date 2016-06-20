# Advanced_Vision_Coursework2
The 2rd coursework of Advanced Vision (UoE, 2016)

Course homepage:　http://www.inf.ed.ac.uk/teaching/courses/av/

## Task Description
In brief, the task is to rebuild a 3D scene by 16 views captured by a Kinect depth sensor. Steps are: 

1. Extract and remove the ground plane from the image data
2. Extract and describe the 3 spheres
3. Use the 3 spheres to register and fuse the XYZ data from all images
4. Extract the 9 planes from the data
5. Build as complete a 3D model as possible and characterise the surfaces.

Details are shown in prac21516.pdf. 

## Data

The data of 16 views can be downloaded from http://homepages.inf.ed.ac.uk/rbf/AVDATA/AV216DATA/av_pcl.mat .

## Files
- ./functions/*.m: Functions used in this coursework. fscatter32.m, plotpcl.m, sphereFit.m and sphereFit test.m are provided by the lecturer. 
- ass_2_f1.m: Script of background extraction
- ass_2_f2.m: Script of registration
- ass_2_f3.m: Script of object plane extraction
- ass_2_f4.m: Script of object model building
- prac21516.pdf: Description of the coursework


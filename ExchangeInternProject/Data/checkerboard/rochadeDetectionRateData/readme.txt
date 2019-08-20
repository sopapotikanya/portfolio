ROCHADE: Robust Checkerboard Advanced Detection for Camera Calibration

       - Evaluation Data Set of the Detection Rate Experiment -

This archive contains the data used for the detection rate experiment of this publication.
An educational MATLAB implementation of ROCHADE can be downloaded on:

	http://www.metrilus.de/rochade

The data set contains images of two stereo camera setups, thr first consisting of two 
Mesa SR4000 ToF cameras and two IDS UI-1241LE5 cameras. The third set is a single camera 
setup and has been captured with a GoPro Hero 3.

The checkerboard detection performs best when downsampling is activated (default setup).
The following half-sizes for the refinement window have been used during the evaluation:

% Mesa:  refinementKernelHalfSize = 2
% IDS:   refinementKernelHalfSize = 5
% GOPro: refinementKernelHalfSize = 20

Feel free to use these images for your evaluation. Please cite the following reference in 
any published work if you use this software or data set. BibTeX data is provided below:


@inproceedings{LNCS86920766, editor = {David Fleet and Tomas Pajdla and Bernt Schiele and Tinne Tuytelaars}, 
  booktitle = {Computer Vision -- ECCV 2014}, 
  publisher = {Springer}, 
  location = {Heidelberg}, 
  series = {Lecture Notes in Computer Science}, 
  volume = {8692}, 
  year = {2014}, 
  isbn = {978-3-319-10592-5}, 
  doi = {10.1007/978-3-319-10593-2_50}, 
  author = {Simon Placht and Peter F\"{u}rsattel and Etienne Assoumou Mengue and Hannes Hofmann and Christian Schaller and Michael Balda and Elli Angelopoulou}, 
  title = {ROCHADE: Robust Checkerboard Advanced Detection for Camera Calibration}, 
  pages = {766--779}
}
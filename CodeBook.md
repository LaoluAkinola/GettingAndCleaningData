# Introduction
This is the code book that describes the variables in the final output of the run_analysis.R script

# Variables
* Subject identifies the individual who performed the activity.
* Activity shows the activity name for the activity being performed by the subject.
* Each signal variable name (columns 3 - 81) can be partitioned into 2 parts. First part is the statistic estimated from the signal in the second part. This signal is either the mean ('mean') or standard deviation ('std') and the part is terminated by one of the 3 axial directions (XYZ) for the signal. The second part has the feature,  the signal represents. The first character, t or f, respectively indicate whether the signal is a time domain signal or was obtained after a Fast Fourier Transfrom was done on a raw signal. A case in pont is the first signal variable "meanX_tBodyAcc". This represents the mean of the Body Acceleration time signal. 
# EHUNAM-dataset
This repository provides information about the EHUNAM dataset: a WiFi CSI-based dataset for human and machine sensing.

The reference paper for the EHUNAM dataset will be available once it is published.

The dataset is open access and can be downloaded from:
https://figshare.com/s/e72ab742beae04818b4e

According to the abstract of the paper:

"EHUNAM is a comprehensive channel state information (CSI) dataset developed for various WiFi sensing applications, with a primary focus on people counting (PC), human activity recognition (HAR), and machine activity recognition (MAR), while remaining suitable for additional tasks. The dataset was acquired using diverse equipment configurations and under different scenarios, ensuring versatility and representativeness. Beyond traditional applications, EHUNAM includes measurements for recognizing activities of home appliances and industrial machines.} To achieve high accuracy in new settings, data was collected over 23 days in eight distinct environments, including an industrial scenario, involving 21 people and nine machines that can also perform activities simultaneously. Validation using a convolutional neural network (CNN) for PC, HAR, and MAR, considering multiclass and multilabel classification, achieved over 90\% accuracy in most cases, underscoring the dataset's robustness and its capacity to tackle a broad spectrum of real-world scenarios."

### Dtwoata pre-processing
In the paper, the results are obtained using two pre-processing steps:

First, the subcarriers that do not contain information (nulls and pilots) were removed because they do not include information about the propagation channel. The file Subcarrier.m, attached to the repository, is used to remove the subcarriers.


Second, a CSI phase processing method, which is described in the following paper: "Channel phase processing in wireless networks for human activity recognition" (DOI: https://doi.org/10.1016/j.iot.2023.100960)


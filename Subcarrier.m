clear; clc;

% Select folder containing .mat files
folderPath = uigetdir('', 'Select folder with .mat files');
if folderPath == 0, disp('No folder selected.'); return; end

% Create "processed" folder for output files
outputFolder = fullfile(folderPath, 'processed');
if ~exist(outputFolder, 'dir'), mkdir(outputFolder); end

% List all .mat files in the folder
matFiles = dir(fullfile(folderPath, '*.mat'));
if isempty(matFiles), disp('No .mat files found.'); return; end

% Define column indices to remove
carrier_remove20_default = [1 2 3 4 33 62 63 64];
carrier_remove80A = [1:6 128:131 252:256];
carrier_remove80B = [1:6 33 60:70 97 124:134 161 188:198 225 252:256];

% Process each .mat file
for i = 1:length(matFiles)
    filePath = fullfile(folderPath, matFiles(i).name);
    disp(['Processing: ', matFiles(i).name]);

    % Load file and check for required variables
    matFile = load(filePath);
    if ~all(isfield(matFile, {'BW', 'CSI', 'Subcarriers'}))
        disp('Missing required variables. Skipping.');
        continue;
    end

    % Extract variables
    BW = matFile.BW;
    CSI = matFile.CSI;
    Subcarriers = matFile.Subcarriers;
    Enviroment= matFile.Enviroment;
    if isfield(matFile, 'Occupied_SC')
        Occupied_SC = matFile.Occupied_SC;
    else
        Occupied_SC = ''; % Default to empty if not present
    end

    % Determine columns to remove based on Subcarriers and BW
    if Subcarriers == 56
        carrier_remove20 = [];
    else
        carrier_remove20 = carrier_remove20_default;
    end

    if BW == 20
        CSI(:, carrier_remove20) = [];
    elseif BW == 80
        if strcmp(Enviroment, 'Industrial Laboratory')
            CSI(:, carrier_remove80B) = [];
        else
            CSI(:, carrier_remove80A) = [];
        end
    else
        disp(['Unsupported BW in file: ', matFiles(i).name]);
        continue;
    end

    % Save modified file to "processed" folder
    save(fullfile(outputFolder, ['mod_', matFiles(i).name]), 'CSI', '-v7.3');
end

disp('Processing completed.');



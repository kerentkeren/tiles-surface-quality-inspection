clear; clc;

%folder data citra sampling
folder = 'tilesimage2\';

%pembentukan matrix fitur F1 s/d F4;
F1b = [];F2b = [];F3b = [];F4b = [];
F1c = [];F2c = [];F3c = [];F4c = [];


%%
%Pembacaan data citra

%citra ubin baik 1-160
for i = 1:160
    filename = strcat(folder, int2str(i),'.png');
    %membaca file citra
    Ib = imread(filename);
    
    %konversi dari RGB ke grayscale
    grayB = rgb2gray(Ib);
    
    %menyimpan citra hasil grayscale ke dalam folder
    imwrite(grayB,(strcat('tilesimage2\gray\gray',num2str(i),'.png')));
    %check data piksel image
    im1= imread('tilesimage2\gray\gray1.png');
    
    % Matriks co-occurance graycomatrix dengan jarak pixel 1d
    % untuk sudut 0,45,90 dan 135
    % Anyway here's the list of offsets (with distance = 1):
    % >>>> 0 derajat : {0,1} ~ 180 derajat
    % >>>> 45 derajat: {-1, 1} ~ 225 derajat
    % >>>> 90 derajat: {-1,0} ~ 270 derajat
    % >>>> 135 derajat: {-1,-1} ~ 315 derajat
    
    offsets1 = [0 1; -1 1; -1 0; -1 -1];
    %statsB = graycoprops(
    
    %offsets0 = [zeros(2,1) (1:2)'];
    %GLCM2 = graycomatrix(gray,'Offset',offsets0);
    glcm = graycomatrix(grayB,'Offset',offsets1);
    %GLCM2 = graycomatrix(gray,'Offset',[2 0;0 2]);
    
    % Perhitungan Fitur Tekstur
    statsB = graycoprops(glcm,{'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
    
    %matriks fitur GLCM
    F1b = [F1b;statsB.Contrast]; %Fitur kontras
    F2b = [F2b;statsB.Correlation]; % Fitur korelasi
    F3b = [F3b;statsB.Energy]; % Fitur energy
    F4b = [F4b;statsB.Homogeneity]; % Fitur homogenitas
end

%250 ubin cacat
for i = 161:410
    filename = strcat(folder, int2str(i),'.png');
    %membaca file citra
    Ic = imread(filename);
    
    % Konversi dari RGB ke grayscale
    grayC = rgb2gray(Ic);
    
    %menyimpan citra hasil grayscale ke dalam folder
    imwrite(grayC,(strcat('tilesimage2\gray\gray',num2str(i),'.png')));
    %check data piksel image
    %im2= imread('tilesimage\gray\gray51.png');
    
    %Matriks co-occurance graycomatrix dengan jarak pixel 1d
    %untuk sudut 0,45,90 dan 135
    
    offsets1 = [0 1; -1 1; -1 0; -1 -1];
    %offsets0 = [zeros(2,1) (1:2)'];
    %GLCM2 = graycomatrix(gray,'Offset',offsets0);
    glcm2 = graycomatrix(grayC,'Offset',offsets1);
    %GLCM2 = graycomatrix(gray,'Offset',[2 0;0 2]);
    
    % Perhitungan Fitur Tekstur
    statsC = graycoprops(glcm2,{'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
    
    %matriks fitur GLCM
    F1c = [F1c;statsC.Contrast]; % Fitur kontras
    F2c = [F2c;statsC.Correlation]; % Fitur korelasi
    F3c = [F3c;statsC.Energy]; % Fitur energi
    F4c = [F4c;statsC.Homogeneity]; % Fitur homogenitas
    
end


%Definisi input
%4 fitur untuk seluruh citra 
X = [F1b F2b F3b F4b ; F1c F2c F3c F4c];

%Definisi Output
y(1:160,:)=1; y(161:410,:)=2;

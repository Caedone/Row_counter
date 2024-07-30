close all; 
clear;
clc;  

%% go to folder with raw csv files to process


addpath(genpath('C:\Users\gangliagurdian\Desktop\Unsupervised Learning\Matlab code\Utilities\Offline'))


savedname='imported';%define name to save imported csv

[importedcsv]= ImportCSVJT(savedname)%function [importedcsv] = ImportCSVJT(savedname) 

for i=1:sum(~cellfun(@isempty,{importedcsv.name})) %print out content of structure to enable next step
    printimportcsv{i,1}=importedcsv(i).name
    printimportcsv{i,2}=importedcsv(i).csv
    printimportcsv{i,3}=i
end

%% Asks which CSV file you would like to count
prompt = 'Which CSV file would you like to count ';
list = input(prompt)

m=1;
extractedcsv=struct('name',{},'csv',{});
    extractedcsv(m).name=importedcsv(list(1,m)).name;
    extractedcsv(m).csv=importedcsv(list(1,m)).csv;
    DataCell={extractedcsv(m).csv};

for j=1:length(DataCell(:,1))
         AccTrunc37=[];
         AccTrunc34=[];
         AccTrunc35=[];

    for i=1:length(DataCell(1,:))   
       
        AccTrunc34=cell2mat(DataCell(j,i)); %pull out array from datacell
        AccTrunc37=AccTrunc34;
        AccTrunc35=AccTrunc34; 

        %remove rows with first column not 3
        AccTrunc34(any(AccTrunc34(:,1)~=3,2),:)=[]; %gives trunacted dataset with register 34 rows pulled out
        AccTrunc37(any(AccTrunc37(:,1)~=3,2),:)=[]; %gives trunacted dataset with register 37 rows pulled out
        AccTrunc35(any(AccTrunc35(:,1)~=3,2),:)=[]; %gives trunacted dataset with register 35 rows pulled out

        %remove rows with registers not 34
        AccTrunc34(any(AccTrunc34(:,2)~=34,2),:)=[]; %gives trunacted dataset with register 34 rows pulled out
        
        %remove rows with registers not 37 
        AccTrunc37(any(AccTrunc37(:,2)~=37,2),:)=[]; %gives trunacted dataset with register 37 rows pulled out
        
        %remove rows with registers not 8 
        AccTrunc35(any(AccTrunc35(:,2)~=35,2),:)=[]; %gives trunacted dataset with register 8 rows pulled out - to process ZG`s optogenetic experiments 
    end
end

% Get the sizes
size_AccTrunc37 = size(AccTrunc37);
size_AccTrunc34 = size(AccTrunc34);
size_AccTrunc35 = size(AccTrunc35);

% Create cell arrays to hold the names and sizes
output = {
    'Register 37', size_AccTrunc37;
    'Register 34', size_AccTrunc34;
    'Register 35', size_AccTrunc35
};

% Display the output
for i = 1:size(output, 1)
    name = output{i, 1};
    dims = output{i, 2};
    fprintf('{''%s''}    {%dx%d double}\n', name, dims(1), dims(2));
end

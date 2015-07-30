%Outer script to set up and run irrigation system model

clear all; 
close all;


%Set seed for random number generator 
randSeed = 14897;
rand('twister',randSeed);
randn('state', randSeed);

%Parameters
timeSteps.total = 1560; %length of simulation
timeSteps.cycle = 52; %e.g., year

%initialize system using setUpIrrigationSystem function (right now just
%contains hard coding of a trivial test case
[farmList, nodeList, linkList, channelList] = setUpIrrigationSystem();


%make a first plot of the system to work from
figure;
visualizeSystem(timeSteps.cycle+1, farmList, nodeList, linkList, timeSteps);

%run model
main(timeSteps, nodeList, farmList, linkList, channelList);
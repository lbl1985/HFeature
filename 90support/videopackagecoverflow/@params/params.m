classdef params
%PARAMS Parameter, Tools and Summary
%   Small objects with all parameters as defaults to get them wherever 
%   I want. Additionally, some tools are there as well, which is not nice.

% Usage: Initiate the object and change your parameters in your own file
% which is NOT in the SVN. This file here should provide Standard
% parameters for testing and stuff, not for experimental usage.

   properties
	release = false;
    savememory = false;
	name = 'Skin Detection';

	colorspace = 'HSI';
    % Harris options ---------------------------------------
    k = 0.04;
	sigma =  3;
	sigma_g = 9; % normally 3 times sigma
	thres = 500;
  	nCorners = 200;
    imdataillum = 'normmean'; %mean sum


	%time Harris options -----------------------------------
	tk = 0.000001;
    %tk = 0.005;
	t = 3;
	t_g =9;
	%tthres = 100000000;
    tthres = 0;
    scaleselection = 'Laplacian';
    
    % jet options -----------------------------------------
    normalizeJets = true;

	extractcorners = true;    % for harris per frame in computeHarrisperframe
	mappedvideo = false;      % draw Harris corners
	mapfeatures = [0 255 0];  % mapfeatures color factor, write features into matrix
	maptimefeat = [0 1 0];    % time harris

    % cluster options -----------------------------------------
    nrCluster = 10;                     %number of clusters
    clusterDistance = 'sqEuclidean'; % 'cityblock' 'cosine' 'correlation'  'Hamming'
	emptyaction = 'singleton';            % 'drop' 'error'
    onlinephase = 'on';
    replicates = 10;
    clusterstart = 'sample'    %'cluster' 'sample' 'uniform' or a Matrix

    %video options -----------------------------------------
	splitVideo = false;
	startframe = 1;
	endframe = 12;
    stackSize = 10;
	%framestep = 1; not possible because of parfor
    

	%matrix2movie -----------------------------------------
	colormap = 'Jet';
    
	%visual options for detector/descriptor output ------------------------
	ellipseElements = 25;
	forvideo = false;  %draw ellipse in 3d
	textverbose = false; %print eigen values and stuff
    showframes = true;
    fontsize = 14;
    fontcolor = 'blue';
    
    % tmpdir = '/ramdisk/';
	tmpdir = '/tmp/';
	%videodir = '/data/julian/cosamedvideos/';
	%videodir = 'cosamed-videooutput/';
	videodir = 'testdata/';
    videoextension = 'mp4'
    %outputdir = 'cosamed-videooutput/query/';
	outputdir = './';
    picformat = 'gif'
    
    %outputfile descriptor/points
    outputfile = '_jet.descr';
    inputfile = 'test.descr';
    
    %converter = 'mencoder';
    converter = 'ffmpeg';
    converterbinary = 'standard';   %in case it does not work, put here 
                                    %/weird/dir/ffmpeg or so

	playwindow = struct;        % window properties defined in constructor
	cflowwindow = struct;       % window properties for plotframes
	cflowproperties = struct;   % window properties for plotframes
	ellproperties = struct;     % line propteries for feature ellipses
	picproperties = struct;     % properties for harris ell drawing
	featureproperties = struct  % used in drawfeatures ?
    
    %descriptor properties -------------------------------
    distance = 'euclidean';
    %distance = 'mahalanobis';
    
    
    %face detector ----------------------------
    facepic = 'testdata/faces.jpg';
    cascade = 'mex/detect/haarcascade_frontalface_alt.xml';
    %cascade = 'mex/detect/haarcascade_fullbody.xml';
    
    %skin detector ------------------------
    skincolorspace = 'YCbCr';
    cbmax = 127;
    cbmin = 77;
    cbrange = 15; % apply both plus and minus
    
    crmax = 173; 
    crmin = 133;
    crrange = 8;
    
    saveskinresults = '';
    justforimages = false; % hack for Jana's experiments
    saveskinmemory = false; %for big videos and small memories
    useonlyskincolorskin = true;
    
   end

   methods 
       function obj = params()
            fprintf('Initialized parameters and tools.a\n');
           % properties of window for simple video play
           obj.playwindow.NumberTitle = 'off';
           obj.playwindow.Name = ['Playing:' obj.name];
           %obj.playwindow.Toolbar = 'none';
           %obj.playwindow.Menubar = 'none';
           %obj.playwindow.Position = [100 100 obj.info.Width obj.info.Height];
           
           %properties of window for cover flow view
           obj.cflowwindow.NumberTitle = 'off';
           obj.cflowwindow.Name = ['Cover Flow:' obj.name];
           
           %properties for cover flow surfs and mapping
           obj.cflowproperties.EdgeColor = 'none';
           obj.cflowproperties.FaceColor = 'texturemap';
           obj.cflowproperties.LineStyle = 'none';
           
           %properties for feature ellipses
           obj.ellproperties.Color = 'red';
           obj.ellproperties.LineStyle = '-';
           obj.ellproperties.LineWidth = 1;
           
           %drawfeatures(p,cdata) ellipse windows.
           obj.picproperties.EdgeColor = 'none';
           obj.picproperties.FaceColor = 'texturemap';
           obj.picproperties.LineStyle = 'none';

           obj.featureproperties.Color = 'yellow';
           obj.featureproperties.LineStyle = '-';
           %obj.featureproperties.FaceAlpha = 0.4;
           
       end
       
       progressbar(obj,i,max,toc, title)
       
   end
end 

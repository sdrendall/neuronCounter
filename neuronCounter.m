function varargout = neuronCounter(varargin)
% NEURONCOUNTER MATLAB code for neuronCounter.fig
%      NEURONCOUNTER, by itself, creates a new NEURONCOUNTER or raises the existing
%      singleton*.
%
%      H = NEURONCOUNTER returns the handle to a new NEURONCOUNTER or the handle to
%      the existing singleton*.
%
%      NEURONCOUNTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEURONCOUNTER.M with the given input arguments.
%
%      NEURONCOUNTER('Property','Value',...) creates a new NEURONCOUNTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before neuronCounter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to neuronCounter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help neuronCounter

% Last Modified by GUIDE v2.5 01-Apr-2014 13:00:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @neuronCounter_OpeningFcn, ...
                   'gui_OutputFcn',  @neuronCounter_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before neuronCounter is made visible.
function neuronCounter_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to neuronCounter (see VARARGIN)
    
    % Choose default command line output for neuronCounter
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    
    % UIWAIT makes neuronCounter wait for user response (see UIRESUME)
    % uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = neuronCounter_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in previousImage.
function previousImage_Callback(hObject, eventdata, handles)
    % hObject    handle to previousImage (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    displayPreviousImage(handles)
    
    
% --- Executes on button press in nextImage.
function nextImage_Callback(hObject, eventdata, handles)
    % hObject    handle to nextImage (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    displayNextImage(handles)
    
    
% --- Executes on button press in saveDisplayedImage.
function saveDisplayedImage_Callback(hObject, eventdata, handles)
    % hObject    handle to saveDisplayedImage (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [filename, path] = uiputfile('*.png', 'Save as...');
    export_fig(handles.mainDisplay, fullfile(path, filename))
    

function loadImages_Callback(hObject, eventdata, handles)
    %% --- Executes on button press in loadImages.
    %
    % hObject    handle to loadImages (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    global images
    % Load images -- Function is recursive by default
    images = searchForImages();
    
    % Display first image
    displayFirstImage(handles);


% --- Executes on button press in markNeurons.
function markNeurons_Callback(hObject, eventdata, handles)
    % hObject    handle to markNeurons (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    manipulateNeuronLabels(handles);
    currIm.neurons.Count


% --- Executes on button press in findNeurons.
function findNeurons_Callback(hObject, eventdata, handles)
    % hObject    handle to findNeurons (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global currIm
    [currIm.labIm, currIm.neurons] = findNeuronsAlgorithm(currIm.image);

    refreshMainDisplay(handles);
    currIm.neurons.Count

% --- Executes on button press in toggleGreen.
function toggleGreen_Callback(hObject, eventdata, handles)
    % hObject    handle to toggleGreen (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Hint: get(hObject,'Value') returns toggle state of toggleGreen
    refreshMainDisplay(handles);


% --- Executes on button press in toggleRed.
function toggleRed_Callback(hObject, eventdata, handles)
    % hObject    handle to toggleRed (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Hint: get(hObject,'Value') returns toggle state of toggleRed
    refreshMainDisplay(handles);


% --- Executes on button press in toggleBlue.
function toggleBlue_Callback(hObject, eventdata, handles)
    % hObject    handle to toggleBlue (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Hint: get(hObject,'Value') returns toggle state of toggleBlue
    refreshMainDisplay(handles);


function displayNextImage(handles)
    %% Displays the next image, wraps around if the last image is being displayed
    global images currImInd currIm

    if currImInd >= size(images, 1)
        currImInd = 1;
    else
        currImInd = currImInd + 1;
    end

    setCurrIm(images(currImInd).path)
    refreshMainDisplay(handles)


function displayPreviousImage(handles)
    %% Loads the previous image in images then refreshes the main display
    global images currImInd currIm

    if currImInd <= 1
        currImInd = size(images, 1);
    else
        currImInd = currImInd - 1;
    end

    setCurrIm(images(currImInd).path)
    refreshMainDisplay(handles)


function displayFirstImage(handles)
    %% Displays the first image in the images struct
    global currIm currImInd images
    currImInd = 1;
    setCurrIm(images(currImInd).path)
    refreshMainDisplay(handles)


function setCurrIm(imPath)
    global currIm
    currIm.image = mat2gray(imread(imPath));
    currIm.labIm = [];


function refreshMainDisplay(handles)
    %% Resets the main display to display images(currImInd)
    % Load im
    global currIm

    dispIm = checkChannelsToDisplay(currIm.image, handles);
    displayOnMain(dispIm, handles)

    if currImHasLabIm()
        overlayOnMain(im2bw(currIm.labIm, 0), handles)
    end


function result = currImHasLabIm()
    %% Checks if the currIm has a neuron labIm
    global currIm
    result = any(strcmp('labIm', fieldnames(currIm))) && ~isempty(currIm.labIm);


function imOut = checkChannelsToDisplay(imIn, h)
    %% Filters and rearranges layers based on user input
    % Returns a new, filtered image
    redChannel = 1;
    greenChannel = 2;
    blueChannel = 3;
    
    channels = [redChannel, greenChannel, blueChannel];

    channelOn(redChannel) = get(h.toggleRed, 'Value');
    channelOn(blueChannel) = get(h.toggleBlue, 'Value');
    channelOn(greenChannel) = get(h.toggleGreen, 'Value');
    
    imOut = zeros(size(imIn));
    for iCh = 1:3
        imOut(:,:,channels(iCh)) = channelOn(iCh)*imIn(:,:,iCh);
    end


function displayOnMain(im, handles)
    %% Displays image 'im' on the main display
    axes(handles.mainDisplay)
    imshow(im)


function overlayOnMain(overlay, handles)
    %% Overlays an image on the main displays
    trans = .5;
    clr = [1 0 0];
    axes(handles.mainDisplay)
    alphamask(overlay, clr, trans);


%% Image Editing Functions
function manipulateNeuronLabels(handles)
    %% Function to allow user manipulation of the neuron mask over currIm
    global currIm

    % Make there is a neuron mask to work with
    if ~currImHasLabIm()
        currIm.labIm = logical(zeros(size(currIm.image)));
    end

    % Get input
    inpt = getInputFromMainDisplay(handles);

    % Process input
    processMainDisplayInput(inpt);

    % Refresh Main Display
    refreshMainDisplay(handles);


function processMainDisplayInput(in)
    %% Calls removeNeurons and addNeurons accordingly

    coordsToAdd = in.bp == 1;
    coordsToRemove = in.bp ==3;

    removeNeurons(in.xInds(coordsToRemove), in.yInds(coordsToRemove));
    addNeurons(in.xInds(coordsToAdd), in.yInds(coordsToAdd));


function removeNeurons(xInds, yInds)
    %% Removes neurons from currIm.neurons and .labIm
    global currIm
    for i = 1:length(xInds)
        nr = yInds(i);
        nc = xInds(i);

        % nr, nc
        nKey = currIm.labIm(nr, nc);
        
        % remove key, update labIm
        if currIm.neurons.isKey(nKey)
            currIm.neurons.remove(nKey);
            currIm.labIm(currIm.labIm == nKey) = 0;
        end
    end

function addNeurons(xInds, yInds)
    %% Adds neurons to currIm.neurons and .labIm
    global currIm
    nRad = 15; % TODO: Make this user defined
    [X, Y] = meshgrid(1:size(currIm.labIm, 2), 1:size(currIm.labIm, 1));

    for i = 1:length(xInds)
        x = xInds(i);
        y = yInds(i);

        newNeuron.Area = pi*nRad^2;
        newNeuron.Centroid = [x, y];
        newNeuron.BoundingBox = [[x, y] - nRad, nRad*2, nRad*2];

        nKey = max(currIm.labIm(:)) + 1;
        currIm.neurons(nKey) = newNeuron;

        % draw a circle on labIm
        circleInds = nRad^2 >= (X - x).^2 + (Y - y).^2;
        currIm.labIm(circleInds) = nKey;
    end


function inpt = getInputFromMainDisplay(handles)
    %% returns a matrix containing the results of ginput on the main window 
    axes(handles.mainDisplay)
    [xInds, yInds, buttonPresses] = ginput();
    inpt.xInds = round(xInds);
    inpt.yInds = round(yInds);
    inpt.bp = buttonPresses;
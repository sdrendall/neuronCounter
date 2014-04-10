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

% Last Modified by GUIDE v2.5 07-Apr-2014 11:03:48

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
    % varargin   command line arguments to neuronCounter (see VARARGIN)

    % Choose default command line output for neuronCounter
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    
    % UIWAIT makes neuronCounter wait for user response (see UIRESUME)
    % uiwait(handles.figure1);

    % Open a parallel pool, for increased processing speed
    if matlabpool('size') == 0
        parpool();
    end

    global imageBuffer images
    clear imageBuffer images
    global imageBuffer images
    imageBuffer = [];
    images = [];


% --- Outputs from this function are returned to the command line.
function varargout = neuronCounter_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    
    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in previousImage.
function previousImage_Callback(hObject, eventdata, handles)

   displayPreviousImage(handles)
    
    
% --- Executes on button press in nextImage.
function nextImage_Callback(hObject, eventdata, handles)

   displayNextImage(handles)
    
    
% --- Executes on button press in saveDisplayedImage.
function saveDisplayedImage_Callback(hObject, eventdata, handles)

    [filename, path] = uiputfile('*.tif', 'Save as...');
    export_fig(handles.mainDisplay, fullfile(path, filename))
    

function loadImages_Callback(hObject, eventdata, handles)
    %% --- Executes on button press in loadImages.
    global images bufferInds

    % Load images -- Function is recursive by default
    images = searchForFISHImages();
    
    % Create a random permutation of the indexes to each image to use for buffering
    bufferInds = randperm(length(images));

    % Display first image
    displayFirstImage(handles);


% --- Executes on button press in markNeurons.
function markNeurons_Callback(hObject, eventdata, handles)
    global imageBuffer
    manipulateNeuronLabels(handles);


% --- Executes on button press in findNeurons.
function findNeurons_Callback(hObject, eventdata, handles)
    global imageBuffer

    analyzeImagesInBuffer;
    refreshMainDisplay(handles);


% --- Executes on button press in toggleGreen.
function toggleGreen_Callback(hObject, eventdata, handles)   
    % Hint: get(hObject,'Value') returns toggle state of toggleGreen
    refreshMainDisplay(handles);


% --- Executes on button press in toggleRed.
function toggleRed_Callback(hObject, eventdata, handles)   
    % Hint: get(hObject,'Value') returns toggle state of toggleRed
    refreshMainDisplay(handles);


% --- Executes on button press in toggleBlue.
function toggleBlue_Callback(hObject, eventdata, handles)   
    % Hint: get(hObject,'Value') returns toggle state of toggleBlue
    refreshMainDisplay(handles);


function imsPerBuff_textBox_Callback(hObject, eventdata, handles)
% eventdata  reserved - to be defined in a future version of MATLAB% Hints: get(hObject,'String') returns contents of imsPerBuff_textBox as text
%        str2double(get(hObject,'String')) returns contents of imsPerBuff_textBox as a double


% --- Executes during object creation, after setting all properties.
function imsPerBuff_textBox_CreateFcn(hObject, eventdata, handles)
    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function blue_maskTextBox_Callback(hObject, eventdata, handles)
    % eventdata  reserved - to be defined in a future version of MATLAB% Hints: get(hObject,'String') returns contents of blue_maskTextBox as text
    %        str2double(get(hObject,'String')) returns contents of blue_maskTextBox as a double
    myValue = get(handles.blue_maskTextBox, 'String');
    set(handles.blue_maskSlider, 'Value', str2double(myValue))
    refreshMainDisplay(handles)

% --- Executes during object creation, after setting all properties.
function blue_maskTextBox_CreateFcn(hObject, eventdata, handles)
    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function green_maskTextBox_Callback(hObject, eventdata, handles)
    % eventdata  reserved - to be defined in a future version of MATLAB% Hints: get(hObject,'String') returns contents of green_maskTextBox as text
    %        str2double(get(hObject,'String')) returns contents of green_maskTextBox as a double
    myValue = get(handles.green_maskTextBox, 'String');
    set(handles.green_maskSlider, 'Value', str2double(myValue))
    refreshMainDisplay(handles)

% --- Executes during object creation, after setting all properties.
function green_maskTextBox_CreateFcn(hObject, eventdata, handles)
    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    


function red_maskTextBox_Callback(hObject, eventdata, handles)
    % Hints: get(hObject,'String') returns contents of red_maskTextBox as text
    %        str2double(get(hObject,'String')) returns contents of red_maskTextBox as a double
    myValue = get(handles.red_maskTextBox, 'String');
    set(handles.red_maskSlider, 'Value', str2double(myValue))
    refreshMainDisplay(handles)


% --- Executes during object creation, after setting all properties.
function red_maskTextBox_CreateFcn(hObject, eventdata, handles)
    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on slider movement.
function red_maskSlider_Callback(hObject, eventdata, handles)
    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    myValue = get(handles.red_maskSlider, 'Value');
    set(handles.red_maskTextBox, 'String', num2str(myValue))
    refreshMainDisplay(handles);


% --- Executes during object creation, after setting all properties.
function red_maskSlider_CreateFcn(hObject, eventdata, handles)
    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
    


% --- Executes on slider movement.
function green_maskSlider_Callback(hObject, eventdata, handles)
    % eventdata  reserved - to be defined in a future version of MATLAB% Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    myValue = get(handles.green_maskSlider, 'Value');
    set(handles.green_maskTextBox, 'String', num2str(myValue))
    refreshMainDisplay(handles);


% --- Executes during object creation, after setting all properties.
function green_maskSlider_CreateFcn(hObject, eventdata, handles)
    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


% --- Executes on slider movement.
function blue_maskSlider_Callback(hObject, eventdata, handles)
    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    myValue = get(handles.blue_maskSlider, 'Value');
    set(handles.blue_maskTextBox, 'String', num2str(myValue))
    refreshMainDisplay(handles);


% --- Executes during object creation, after setting all properties.
function blue_maskSlider_CreateFcn(hObject, eventdata, handles)
    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end  


% --- Executes on slider movement.
function transparency_maskSlider_Callback(hObject, eventdata, handles)
    % eventdata  reserved - to be defined in a future version of MATLAB% Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    myValue = get(handles.transparency_maskSlider, 'Value');
    set(handles.transparency_textBox, 'String', num2str(myValue))
    refreshMainDisplay(handles)


% --- Executes during object creation, after setting all properties.
function transparency_maskSlider_CreateFcn(hObject, eventdata, handles)
    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end



function transparency_textBox_Callback(hObject, eventdata, handles)
    % eventdata  reserved - to be defined in a future version of MATLAB% Hints: get(hObject,'String') returns contents of transparency_textBox as text
    %        str2double(get(hObject,'String')) returns contents of transparency_textBox as a double
    myValue = get(handles.transparency_textBox, 'String');
    set(handles.transparency_maskSlider, 'Value', str2double(myValue))
    refreshMainDisplay(handles)


% --- Executes during object creation, after setting all properties.
function transparency_textBox_CreateFcn(hObject, eventdata, handles)
    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function currImInBuff_textBox_Callback(hObject, eventdata, handles)
% eventdata  reserved - to be defined in a future version of MATLAB% Hints: get(hObject,'String') returns contents of currImInBuff_textBox as text
%        str2double(get(hObject,'String')) returns contents of currImInBuff_textBox as a double


% --- Executes during object creation, after setting all properties.
function currImInBuff_textBox_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runStats.
function runStats_Callback(hObject, eventdata, handles)
    global images
    for i = 1:length(images)
        disp(images(i))
        disp('----------------')
    end

% --- Executes on button press in exportResults.
function exportResults_Callback(hObject, eventdata, handles)
    global images

    % Package data into a cell array of structs
    data = packageData(images);

    % Plot on side window
    plotData(data, handles)

    % Export to Csv
    exportToCsv(data)

    % Send to plotly
    sendToPlotly(data)


% --- Executes on button press in loadNextBuffer.
function loadNextBuffer_Callback(hObject, eventdata, handles)
    %% Loads the next set of images into the imageBuffer
    % Number of images loaded is deterimed by user input
    global bufferInds

    % Get index array
    bufferSize = str2double(get(handles.imsPerBuff_textBox, 'String'))

    if bufferSize <= length(bufferInds)
        inds = bufferInds(1:bufferSize);
        bufferInds(1:bufferSize) = [];
    else
        inds = bufferInds(1:end);
        bufferInds(1:end) = [];
    end

    % Buffer over indexes
    bufferImages(inds)

    displayFirstImage(handles);


function displayNextImage(handles)
    %% Displays the next image, wraps around if the last image is being displayed
    global currImInd imageBuffer

    if currImInd >= size(imageBuffer, 2);
        currImInd = 1;
    else
        currImInd = currImInd + 1;
    end

    refreshMainDisplay(handles)
    set(handles.currImInBuff_textBox, 'String', num2str(currImInd))


function displayPreviousImage(handles)
    %% Loads the previous image in images then refreshes the main display
    global currImInd imageBuffer

    if currImInd <= 1
        currImInd = size(imageBuffer, 2);
    else
        currImInd = currImInd - 1;
    end

    refreshMainDisplay(handles)
    set(handles.currImInBuff_textBox, 'String', num2str(currImInd))


function displayFirstImage(handles)
    %% Displays the first image in the images struct
    global imageBuffer currImInd images

    currImInd = 1;

    % buffer the first image in images if none have been buffered yet
    if isempty(imageBuffer)
        bufferImages(1);
    end

    refreshMainDisplay(handles)
    set(handles.currImInBuff_textBox, 'String', num2str(currImInd))


function bufferImages(inds)
    %% fills imageBuffer with images from the "images" object array indexed by "inds"
    global imageBuffer images

    % Bulky for memory management, clear old buffer, create new global
    clear imageBuffer
    global imageBuffer
    imageBuffer = [];
    for i = 1:length(inds)
        imageBuffer = [imageBuffer, bufferedImage(images(inds(i)))];
        imageBuffer(i).dataObj.bufferPos = i;
    end

    disp(imageBuffer)


function refreshMainDisplay(handles)
    %% Resets the main display to display images(currImInd)
    % Load im
    global imageBuffer currImInd

    dispIm = checkChannelsToDisplay(imageBuffer(currImInd).im, handles);
    displayOnMain(dispIm, handles)

    if currImHasLabIm()
        overlayOnMain(double(imageBuffer(currImInd).labIm > 1), handles)
    end


function result = currImHasLabIm()
    %% Checks if the currIm has a neuron labIm
    global imageBuffer currImInd
    result = ~isempty(imageBuffer(currImInd).labIm);


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

    imIn = mat2gray(imIn);
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
    trans = str2double(get(handles.transparency_textBox, 'String'));
    r = str2double(get(handles.red_maskTextBox, 'String'));
    g = str2double(get(handles.green_maskTextBox, 'String'));
    b = str2double(get(handles.blue_maskTextBox, 'String'));
    clr = [r g b];
    axes(handles.mainDisplay)
    alphamask(overlay, clr, trans);


%% Image Processing Functions
function analyzeImagesInBuffer
    global imageBuffer

    % Create some containers, to allow for parallelization
    labIms = cell(size(imageBuffer));
    neurons = labIms;
    totalNeuronCounts = zeros(size(imageBuffer));

    % Analyze buffered images
    parfor i = 1:length(imageBuffer)
        [labIms{i}, neurons{i}] = findNeurons(imageBuffer(i).im);
        totalNeuronCounts(i) = estimateTotalNeuronsFromDapi(imageBuffer(i).im);
    end

    for i = 1:length(imageBuffer)
        % Store values in data objects
        imageBuffer(i).labIm = labIms{i};
        imageBuffer(i).dataObj.neurons = neurons{i};
        imageBuffer(i).dataObj.totalNeuronCount = totalNeuronCounts(i);

        % Spit out some values
        disp(['totalNeuronCount: ', num2str(imageBuffer(i).dataObj.totalNeuronCount)])
        disp(['% expressing neurons: ', num2str(imageBuffer(i).dataObj.percentNeuronsExpressing())])
        disp('------------------------------------')
    end


function neuronCount = estimateTotalNeuronsFromDapi(im)
    dapi = im(:,:,3);
    bw = im2bw(dapi, graythresh(dapi));
    % estimate number of nuclei based on avg number of pixels in a nucleus
    neuronCount = sum(bw(:))/(100*pi);


%% Image Editing Functions
function manipulateNeuronLabels(handles)
    %% Function to allow user manipulation of the neuron mask over currIm
    global imageBuffer currImInd

    % Make there is a neuron mask to work with
    if ~currImHasLabIm()
        imageBuffer(currImInd).labIm = double(zeros(size(imageBuffer(currImInd).im)));
    end

    % Get input
    inpt = getInputFromMainDisplay(handles);

    % Process input
    processMainDisplayInput(inpt);

    % Refresh Main Display
    refreshMainDisplay(handles);


function processMainDisplayInput(in)
    %% Calls removeNeurons and addNeurons accordingly
    % "input.buttonPress"
    coordsToAdd = in.bp == 1;
    coordsToRemove = in.bp ==3;

    % Add and remove neurons
    addNeurons(in.xInds(coordsToAdd), in.yInds(coordsToAdd));
    removeNeurons(in.xInds(coordsToRemove), in.yInds(coordsToRemove));


function addNeurons(xInds, yInds)
    global imageBuffer currImInd
    %% Adds neurons to imageBuffer.neurons and .labIm
    nRad = 15; % TODO: Make this user defined
    [X, Y] = meshgrid(1:size(imageBuffer(currImInd).labIm, 2), 1:size(imageBuffer(currImInd).labIm, 1));

    for i = 1:length(xInds)
        x = xInds(i);
        y = yInds(i);

        newNeuron.Area = pi*nRad^2;
        newNeuron.Centroid = [x, y];
        newNeuron.BoundingBox = [[x, y] - nRad, nRad*2, nRad*2];

        nKey = max(imageBuffer(currImInd).labIm(:)) + 1;
        imageBuffer(currImInd).dataObj.neurons(nKey) = newNeuron;

        % draw a circle on labIm
        circleInds = nRad^2 >= (X - x).^2 + (Y - y).^2;
        imageBuffer(currImInd).labIm(circleInds) = nKey;
    end


function removeNeurons(xInds, yInds)
    global imageBuffer currImInd
    %% Removes neurons from imageBuffer.dataObj.neurons and .labIm
    for i = 1:length(xInds)
        nr = yInds(i);
        nc = xInds(i);

        % nr, nc
        nKey = imageBuffer(currImInd).labIm(nr, nc);
        
        % remove key, update labIm
        if imageBuffer(currImInd).dataObj.neurons.isKey(nKey)
            imageBuffer(currImInd).dataObj.neurons.remove(nKey);
            imageBuffer(currImInd).labIm(imageBuffer(currImInd).labIm == nKey) = 0;
        end
    end


function inpt = getInputFromMainDisplay(handles)
    %% returns a matrix containing the results of ginput on the main window 
    axes(handles.mainDisplay)
    [xInds, yInds, buttonPresses] = ginput();
    inpt.xInds = round(xInds);
    inpt.yInds = round(yInds);
    inpt.bp = buttonPresses;


function sendToPlotly(data)
    plotlyLogin;
    response = plotly(data)


function exportToCsv(data)
    


function plotData(data, h)
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

% Last Modified by GUIDE v2.5 21-Mar-2014 11:09:21

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
    export_fig(handles.mainWindow, fullfile(path, filename))
    

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
    currIm = mat2gray(imread(imPath));

function refreshMainDisplay(handles)
    %% Resets the main display to display images(currImInd)
    % Load im
    global currIm

    dispIm = checkChannelsToDisplay(currIm, handles);
    displayOnMain(dispIm, handles)


function imOut = checkChannelsToDisplay(imIn, h)
    %% Filters and rearranges layers based on user input
    % Returns a new, filtered image
    redChannel = 1;
    greenChannel = 2;
    blueChannel = 3;
    
    channels = [redChannel, greenChannel, blueChannel];

    channelOn(redChannel) = get(h.toggleRed, 'Value')
    channelOn(blueChannel) = get(h.toggleBlue, 'Value')
    channelOn(greenChannel) = get(h.toggleGreen, 'Value')
    
    imOut = zeros(size(imIn));
    for iCh = 1:3
        imOut(:,:,channels(iCh)) = channelOn(iCh)*imIn(:,:,iCh);
    end


function displayOnMain(im, handles)
    %% Displays image 'im' on the main display
    axes(handles.mainDisplay)
    imshow(im)
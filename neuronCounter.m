function varargout = neuronCounter(varargin)
%NEURONCOUNTER M-file for neuronCounter.fig
%      NEURONCOUNTER, by itself, creates a new NEURONCOUNTER or raises the existing
%      singleton*.
%
%      H = NEURONCOUNTER returns the handle to a new NEURONCOUNTER or the handle to
%      the existing singleton*.
%
%      NEURONCOUNTER('Property','Value',...) creates a new NEURONCOUNTER using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to neuronCounter_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      NEURONCOUNTER('CALLBACK') and NEURONCOUNTER('CALLBACK',hObject,...) call the
%      local function named CALLBACK in NEURONCOUNTER.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help neuronCounter

% Last Modified by GUIDE v2.5 02-Apr-2014 16:01:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @neuronCounter_OpeningFcn, ...
                   'gui_OutputFcn',  @neuronCounter_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

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


% --- Executes on button press in nextImage.
function nextImage_Callback(hObject, eventdata, handles)
% hObject    handle to nextImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveDisplayedImage.
function saveDisplayedImage_Callback(hObject, eventdata, handles)
% hObject    handle to saveDisplayedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadImages.
function loadImages_Callback(hObject, eventdata, handles)
% hObject    handle to loadImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in markNeurons.
function markNeurons_Callback(hObject, eventdata, handles)
% hObject    handle to markNeurons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in findNeurons.
function findNeurons_Callback(hObject, eventdata, handles)
% hObject    handle to findNeurons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function imsPerBuff_textBox_Callback(hObject, eventdata, handles)
% hObject    handle to imsPerBuff_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imsPerBuff_textBox as text
%        str2double(get(hObject,'String')) returns contents of imsPerBuff_textBox as a double


% --- Executes during object creation, after setting all properties.
function imsPerBuff_textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imsPerBuff_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blue_maskTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to blue_maskTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blue_maskTextBox as text
%        str2double(get(hObject,'String')) returns contents of blue_maskTextBox as a double


% --- Executes during object creation, after setting all properties.
function blue_maskTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blue_maskTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function green_maskTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to green_maskTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of green_maskTextBox as text
%        str2double(get(hObject,'String')) returns contents of green_maskTextBox as a double


% --- Executes during object creation, after setting all properties.
function green_maskTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to green_maskTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function red_maskTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to red_maskTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of red_maskTextBox as text
%        str2double(get(hObject,'String')) returns contents of red_maskTextBox as a double


% --- Executes during object creation, after setting all properties.
function red_maskTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_maskTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function red_maskSlider_Callback(hObject, eventdata, handles)
% hObject    handle to red_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function red_maskSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to red_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function green_maskSlider_Callback(hObject, eventdata, handles)
% hObject    handle to green_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function green_maskSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to green_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blue_maskSlider_Callback(hObject, eventdata, handles)
% hObject    handle to blue_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blue_maskSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blue_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function transparency_maskSlider_Callback(hObject, eventdata, handles)
% hObject    handle to transparency_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function transparency_maskSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to transparency_maskSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function transparency_textBox_Callback(hObject, eventdata, handles)
% hObject    handle to transparency_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of transparency_textBox as text
%        str2double(get(hObject,'String')) returns contents of transparency_textBox as a double


% --- Executes during object creation, after setting all properties.
function transparency_textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to transparency_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in toggleGreen.
function toggleGreen_Callback(hObject, eventdata, handles)
% hObject    handle to toggleGreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggleGreen


% --- Executes on button press in toggleRed.
function toggleRed_Callback(hObject, eventdata, handles)
% hObject    handle to toggleRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggleRed


% --- Executes on button press in toggleBlue.
function toggleBlue_Callback(hObject, eventdata, handles)
% hObject    handle to toggleBlue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggleBlue



function currImInBuff_textBox_Callback(hObject, eventdata, handles)
% hObject    handle to currImInBuff_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of currImInBuff_textBox as text
%        str2double(get(hObject,'String')) returns contents of currImInBuff_textBox as a double


% --- Executes during object creation, after setting all properties.
function currImInBuff_textBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to currImInBuff_textBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadNextBuffer.
function loadNextBuffer_Callback(hObject, eventdata, handles)
% hObject    handle to loadNextBuffer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in runStats.
function runStats_Callback(hObject, eventdata, handles)
% hObject    handle to runStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exportResults.
function exportResults_Callback(hObject, eventdata, handles)
% hObject    handle to exportResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

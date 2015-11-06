function varargout = DigiCommGame_GUI(varargin)
% DIGICOMMGAME_GUI MATLAB code for DigiCommGame_GUI.fig
%      DIGICOMMGAME_GUI, by itself, creates a new DIGICOMMGAME_GUI or raises the existing
%      singleton*.
%
%      H = DIGICOMMGAME_GUI returns the handle to a new DIGICOMMGAME_GUI or the handle to
%      the existing singleton*.
%
%      DIGICOMMGAME_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIGICOMMGAME_GUI.M with the given input arguments.
%
%      DIGICOMMGAME_GUI('Property','Value',...) creates a new DIGICOMMGAME_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DigiCommGame_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DigiCommGame_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DigiCommGame_GUI

% Last Modified by GUIDE v2.5 08-Oct-2015 12:53:29

% Begin initialization code - DO NOT EDIT
global BandwidthRestrictions
BandwidthRestrictions = 0;

% global UserTries
% UserTries = 0;

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @DigiCommGame_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @DigiCommGame_GUI_OutputFcn, ...
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



% --- Executes just before DigiCommGame_GUI is made visible.
function DigiCommGame_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DigiCommGame_GUI (see VARARGIN)

global name_entered
global started
global rate_entered
global log_str
global log_exists

name_entered = 0;
started = 0;
rate_entered = 0;
log_str = '';
log_exists = 0;

% Choose default command line output for DigiCommGame_GUI
handles.output = hObject;

set(hObject, 'DeleteFcn', @DigiCommGame_GUI_ClosingFcn)

set(handles.BERReq,'String',num2str(100));
set(handles.TxPwr,'String',num2str(100));
handles.game_level = 1;
handles.modulation_chosen = 'BPSK';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DigiCommGame_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = DigiCommGame_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function DigiCommGame_GUI_ClosingFcn(hObject, eventdata, handles)
global log_str
global log_exists

data = guidata(hObject);

if(log_exists)
    % Define these variables appropriately:
    email = 'VTDigiCommGameGUI@gmail.com'; %Your GMail email address
    password = 'Wireless@VT'; %Your GMail password

    % Then this code will set up the preferences properly:
    setpref('Internet','E_mail',email);
    setpref('Internet','SMTP_Server','smtp.gmail.com');
    setpref('Internet','SMTP_Username',email);
    setpref('Internet','SMTP_Password',password);
    props = java.lang.System.getProperties;
    props.setProperty('mail.smtp.auth','true');
    props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
    props.setProperty('mail.smtp.socketFactory.port','465');

    % Send the email
    sendmail(email, ['GUI results for ', data.name_val], log_str)
end

% --- Executes on selection change in Game_Level.
function Game_Level_Callback(hObject, eventdata, handles)
% hObject    handle to Game_Level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Game_Level contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Game_Level
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
switch str{val};
    case '1' % User selects Level 1.
        handles.game_level = 1;
    case '2' % User selects Level 2
        handles.game_level = 2;
    case '3' % User selects Level 3
        handles.game_level = 3;
    case '4' % User selects Level 4
        handles.game_level = 4;
end

% Save the handles structure.
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function Game_Level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Game_Level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Modulation_Scheme.
function Modulation_Scheme_Callback(hObject, eventdata, handles)
% hObject    handle to Modulation_Scheme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Modulation_Scheme contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Modulation_Scheme
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
switch str{val};
    case 'BPSK' % User selects BPSK
        handles.modulation_chosen = 'BPSK';
    case 'QPSK' % User selects QPSK
        handles.modulation_chosen = 'QPSK';
    case '8-PSK' % User selects 8PSK
        handles.modulation_chosen = '8-PSK';
    case '16-QAM' % User selects 16QAM
        handles.modulation_chosen = '16-QAM';
    case '64-QAM' % User selects 64QAM
        handles.modulation_chosen = '64-QAM';
end
% Save the handles structure.
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function Modulation_Scheme_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Modulation_Scheme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_Rate_Trial as text
%        str2double(get(hObject,'String')) returns contents of Data_Rate_Trial as a double
global name_entered
name_entered = 1;
handles.name_val = get(hObject,'String');
% disp(handles.name_val);
% disp(strcat({'You chose '},{num2str(handles.data_rate_trial)}))
guidata(hObject,handles)


function Data_Rate_Trial_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Rate_Trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Data_Rate_Trial as text
%        str2double(get(hObject,'String')) returns contents of Data_Rate_Trial as a double
global rate_entered
rate_entered = 1;
handles.data_rate_trial = str2num(get(hObject,'String'));
% disp(strcat({'You chose '},{num2str(handles.data_rate_trial)}))
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Data_Rate_Trial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Data_Rate_Trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function figure1_WindowKeyPressFcn(hObject, eventdata, handles)



% --- Executes on button press in YES.
function YES_Callback(hObject, eventdata, handles)
% hObject    handle to YES (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global UserTries
global MaxDataRate
global BER
global EbNo_req
global log_str
global name_entered
global started
global rate_entered

if(started && rate_entered)
    modulation = handles.modulation_chosen;
    DataRate = handles.data_rate_trial;
    BER_req = str2num(get(handles.BERReq,'String'));

    % increment tries counter
    UserTries = UserTries + 1;
    set(handles.UserTries,'String',UserTries);

    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'Hint:'})]);

    % give different hints depending on the situation
    if strcmp(modulation,'BPSK') && (BER >= BER_req)
        set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'    Perhaps try reducing your data rate.'})]);
    elseif ~strcmp(modulation,'BPSK') && (BER <= BER_req)
        set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'    Perhaps try increasing your data rate or modulation order.'})]);
    elseif (BER >= BER_req)
        set(handles.output_messages,'String',[get(handles.output_messages,'String'); strcat({'    You will need to reduce the modulation order or data rate to'}); ...
            strcat({'    meet the required BER.'});]);
    else
        set(handles.output_messages,'String',[get(handles.output_messages,'String');'    Try Other Modulation, Rate Combinations']);
    end

    % round differently depending on how close they are
    percent = abs(MaxDataRate-DataRate)/MaxDataRate*100;
    if percent > 5
        percent = 10*ceil(percent/10);
    else
        percent = ceil(percent);
    end

    % give hint based on how close they are the the max rate and the required
    % EbNo for their modulation scheme
    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'    You are within +/- '},{num2str(percent)},{'% of the maximum rate.'})]);
    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'    The required Eb/No for your modulation scheme is '},{num2str(10*log10(EbNo_req))},'dB')]);
    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({''});]);
    set(handles.EbNoRequired,'String',10*log10(EbNo_req))

    % auto-scroll output
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);

    % append to log string
    log_str = sprintf([log_str, 'Attempt ', num2str(UserTries), ': Requested Hint\n']);
    
elseif (started)
    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'Enter a desired data rate!'});strcat({''})]);
    
    % auto-scroll output (was working but now isn't for some reason)
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
elseif (~name_entered)
    set(handles.output_messages,'String',[get(handles.output_messages,'String'); ...
        strcat({'Please enter your full name, select a level, and hit start!'});strcat({''})]);
    
    % auto-scroll output (was working but now isn't for some reason)
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
else
    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'Select a level and hit start!'});strcat({''})]);
    
    % auto-scroll output (was working but now isn't for some reason)
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
end
    
guidata(hObject,handles)

% --- Executes on button press in RUN.
function RUN_Callback(hObject, eventdata, handles)
% hObject    handle to RUN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject,handles)
global BandwidthRestrictions
global UserTries
global MaxDataRate
global BER
global EbNo_req
global log_str
global log_exists
global started
global rate_entered

if(started && rate_entered)
    
    if(~log_exists)
        log_exists = 1;
    end
    
    BER_req = str2num(get(handles.BERReq,'String'));
    TxPwr = str2num(get(handles.TxPwr,'String'));
    Distance = str2num(get(handles.Distance,'String'));

    % BandwidthRestrictions = str2num(get(handles.BandwidthRestrictions,'String'));
    if BandwidthRestrictions
        Bandwidth = str2num(get(handles.BW_Available,'String'));
    end
    NodB = -100; % dBm
    PLexp = 2;


    %%% Limit Calculations
    if BandwidthRestrictions
        set(handles.BW_Available,'String',Bandwidth);

        %BPSK - due to power restrictions
        tmp = qfuncinv(BER_req);
        EbNo_req = 0.5*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        DataRatedB  = Pr - NodB - 10*log10(EbNo_req);
        MaxDataRateBPSK = 10^(0.1*DataRatedB);
        % BPSK - add bandwidth restrictions
        MaxDataRateBPSK = min(MaxDataRateBPSK, 1e6*Bandwidth);

        % QPSK
        MaxDataRateQPSK = min(MaxDataRateBPSK, 1e6*2*Bandwidth);

        % 8-PSK
        tmp = qfuncinv(3*BER_req);
        EbNo_req = 1/6*1/(sin(pi/8))^2*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        DataRatedB  = Pr - NodB - 10*log10(EbNo_req);
        MaxDataRate8PSK = 10^(0.1*DataRatedB);
        MaxDataRate8PSK = min(MaxDataRate8PSK, 1e6*3*Bandwidth);


        MaxDataRate = max([MaxDataRateBPSK, MaxDataRateQPSK, MaxDataRate8PSK]);
    else
        set(handles.BW_Available,'String',{'Inf.'})
        % determine the max data rate
        % Since no bandwidth restrictions, BPSK or QPSK are optimal
        tmp = qfuncinv(BER_req);
        EbNo_req = 0.5*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        DataRatedB  = Pr - NodB - 10*log10(EbNo_req);
        MaxDataRate = 10^(0.1*DataRatedB);

    end

    set(handles.UserTries,'String',UserTries);
    hint = 0;

    UserTries = UserTries + 1;
    set(handles.UserTries,'String',UserTries);
    modulation = handles.modulation_chosen;
    DataRate = handles.data_rate_trial;

    % append to log string
    log_str = sprintf([log_str, 'Attempt ', num2str(UserTries), ': Attempted Solution (', modulation, ' ', num2str(DataRate), ' bits/sec)\n']);

    if strcmp(modulation,'BPSK')

        tmp = qfuncinv(BER_req);
        EbNo_req = 0.5*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        EbNodB = Pr - 10*log10(DataRate) - NodB;
        EbNo = 10^(EbNodB/10);
        BER = qfunc(sqrt(2*EbNo));

        ActualBandwidth = DataRate/1e6;

        if BandwidthRestrictions
            MetBandwidth = (ActualBandwidth <= Bandwidth);
        else
            MetBandwidth = 1;
        end

        set(handles.Occupied_BW,'String',strcat({num2str(ActualBandwidth)},{'MHz'}));
        set(handles.EbNodB,'String',EbNodB);
        set(handles.BER,'String',BER);


    elseif strcmp(modulation,'QPSK')
        tmp = qfuncinv(BER_req);
        EbNo_req = 0.5*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        EbNodB = Pr - 10*log10(DataRate) - NodB;
        EbNo = 10^(EbNodB/10);
        BER = qfunc(sqrt(2*EbNo));

        ActualBandwidth = DataRate/2/1e6;
        if BandwidthRestrictions
            MetBandwidth = (ActualBandwidth <= Bandwidth);
        else
            MetBandwidth = 1;
        end

        set(handles.Occupied_BW,'String',strcat({num2str(ActualBandwidth)},{'MHz'}));
        set(handles.EbNodB,'String',EbNodB);
        set(handles.BER,'String',BER);

    elseif strcmp(modulation,'8-PSK')
        tmp = qfuncinv(3*BER_req);
        EbNo_req = 1/6*1/(sin(pi/8))^2*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        EbNodB = Pr - 10*log10(DataRate) - NodB;
        EbNo = 10^(EbNodB/10);
        BER = 1/3*qfunc(sqrt(6*EbNo*(sin(pi/8))^2));

        ActualBandwidth = DataRate/3/1e6;
        if BandwidthRestrictions
            MetBandwidth = (ActualBandwidth <= Bandwidth);
        else
            MetBandwidth = 1;
        end

        set(handles.Occupied_BW,'String',strcat({num2str(ActualBandwidth)},{'MHz'}));
        set(handles.EbNodB,'String',EbNodB);
        set(handles.BER,'String',BER);

    elseif strcmp(modulation,'16-QAM')
        tmp = erfcinv(BER_req*8/3);
        EbNo_req = 5/2*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        EbNodB = Pr - 10*log10(DataRate) - NodB;
        EbNo = 10^(EbNodB/10);
        BER = 3/8*erfc(sqrt(2/5*EbNo));

        ActualBandwidth = DataRate/4/1e6;
        if BandwidthRestrictions
            MetBandwidth = (ActualBandwidth <= Bandwidth);
        else
            MetBandwidth = 1;
        end

        set(handles.Occupied_BW,'String',strcat({num2str(ActualBandwidth)},{'MHz'}));
        set(handles.EbNodB,'String',EbNodB);
        set(handles.BER,'String',BER);

    elseif strcmp(modulation,'64-QAM')
        tmp = erfcinv(BER_req*24/7);
        EbNo_req = 7*tmp^2;
        Pr = TxPwr - PLexp*10*log10(Distance);
        EbNodB = Pr - 10*log10(DataRate) - NodB;
        EbNo = 10^(EbNodB/10);
        BER = 7/24*erfc(sqrt(EbNo/7));

        ActualBandwidth = DataRate/6/1e6;
        if BandwidthRestrictions
            MetBandwidth = (ActualBandwidth <= Bandwidth);
        else
            MetBandwidth = 1;
        end

        set(handles.Occupied_BW,'String',strcat({num2str(ActualBandwidth)},{'MHz'}));
        set(handles.EbNodB,'String',EbNodB);
        set(handles.BER,'String',BER);

    else
        set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'Dont support this modulation.  Try Again'})]);
        DataRate = 0;
    end


    % if they have succeeded in maximizing the rate
    if (DataRate > 0.98*MaxDataRate) & (BER <= BER_req) & MetBandwidth
        started = 0;
        rate_entered = 0;
        set(handles.output_messages,'String',[get(handles.output_messages,'String');...
            strcat({'Congratulations!  You have maximized the data rate!'});...
            strcat({'Actual max rate is '},{num2str(MaxDataRate)});...
            strcat({'It took you '},{num2str(UserTries)},{' tries.'}); strcat({''})]);

        % auto-scroll output (was working but now isn't for some reason)
        out_message_box = findjobj(handles.output_messages);
        out_message_scroll = out_message_box.getComponent(0).getComponent(0);
        out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
        
        % append success to log
        log_str = sprintf([log_str, 'User maximized the data rate on attempt ', num2str(UserTries), '\n']);

    else
        % print an explanation of why they have not succeeded yet
        if (BER <= BER_req)
            set(handles.output_messages,'String',[get(handles.output_messages,'String'); strcat({'You have not reached the maximum achievable data rate.'});]);
        else
            set(handles.output_messages,'String',[get(handles.output_messages,'String'); strcat({'You have failed to meet the required BER.'});]);
        end   
        set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({''});]);

        % auto-scroll output (was working but now isn't for some reason)
        out_message_box = findjobj(handles.output_messages);
        out_message_scroll = out_message_box.getComponent(0).getComponent(0);
        out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);

    end
elseif (started)
    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'Enter a desired data rate!'});strcat({''})]);
    
    % auto-scroll output (was working but now isn't for some reason)
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
else
    set(handles.output_messages,'String',[get(handles.output_messages,'String');strcat({'Select a level and hit start!'});strcat({''})]);
    
    % auto-scroll output (was working but now isn't for some reason)
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
end

guidata(hObject,handles)



function BERReq_Callback(hObject, eventdata, handles)
% hObject    handle to BERReq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BERReq as text
%        str2double(get(hObject,'String')) returns contents of BERReq as a double
% set(handles.BERReq,'String',num2str(BER_req));
global UserTries

handles.BERReq = str2num(get(hObject,'String'));
set(handles.BERReq,'String',num2str(0));
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function BERReq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BERReq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TxPwr_Callback(hObject, eventdata, handles)
% hObject    handle to TxPwr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxPwr as text
%        str2double(get(hObject,'String')) returns contents of TxPwr as a double
global UserTries
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function TxPwr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxPwr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles)

BER_req = 10^-3;
global log_str
global name_entered
global started
global BandwidthRestrictions
global UserTries

if(name_entered)
    started = 1;
    BandwidthRestrictions = 0;
    UserTries = 0;

    % append to log string
    log_str = sprintf([log_str, '\nUser beginning level ', num2str(handles.game_level), '\n']);

    if handles.game_level == 1
        TxPwr = 10;
        Distance = 200;
    elseif handles.game_level == 2;
        TxPwr = round(10*rand);
        Distance = 200;
    elseif handles.game_level == 3
        TxPwr = round(10*rand);
        Distance = 500*rand;
        BER_req = 10^(-1*ceil(rand*3));
    elseif handles.game_level == 4
        TxPwr = round(20*rand);
        Distance = 500*rand;
        BER_req = 10^(-1*ceil(rand*3));
        BandwidthRestrictions = 1;
        Bandwidth = 1*ceil(10*rand)/10;
    else
        error('Chose an incorrect level.')
    end

    PLexp = 2;

    set(handles.output_messages,'String',[get(handles.output_messages,'String');...
        strcat({''}); strcat({'Choose a modulation scheme to maximize the possible data rate given a '},{num2str(BER_req)},{' error rate (or better) is required.'})]);
    set(handles.output_messages,'String',[get(handles.output_messages,'String');...
        strcat({'The transmit power is '},{num2str(TxPwr)},{'dBm, the transmission distance is '},{num2str(Distance)},{'m, and the path loss exponent is '},{num2str(PLexp)})]);

    set(handles.UserTries,'String',UserTries);
    set(handles.BERReq,'String',num2str(BER_req));
    set(handles.TxPwr,'String',num2str(TxPwr));
    set(handles.Distance,'String',num2str(Distance));

    if BandwidthRestrictions == 1
        set(handles.BW_Available,'String',num2str(Bandwidth));
    else
        set(handles.BW_Available,'String',{'Inf.'})
    end
    set(handles.output_messages,'String',[get(handles.output_messages,'String');...
        strcat({'The noise floor is -100dBm/W and optimal pulse shaping is assumed.'}); strcat({''})]);

    % auto-scroll output (was working but now isn't for some reason)
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
else
    set(handles.output_messages,'String',[get(handles.output_messages,'String');...
        strcat({''}); strcat({'Please enter your full name before starting!'}); strcat({'(Being used for validation)'}); strcat({''})]);

    % auto-scroll output (was working but now isn't for some reason)
    out_message_box = findjobj(handles.output_messages);
    out_message_scroll = out_message_box.getComponent(0).getComponent(0);
    out_message_scroll.setCaretPosition(out_message_scroll.getText().length()-1);
end
    
%% Initialisation routine
clearvars
addpath('E:\USERS\Nikhil');

% Get the classes for the microcontroller:
import mbed.*

% Open and reset the controller:
stty = ('COM10');
if isempty(stty)
    disp('Cannot find mbed controller')
    return
end
mbed_con = SerialRPC(stty, 9600);
mbed_con.reset

% Create stimulation objects for subsequent use:
stim1 = mbed.DigitalOut(mbed_con, p6);
stim2 = mbed.DigitalOut(mbed_con, p7);
stim3 = mbed.DigitalOut(mbed_con, p8);
stim4 = mbed.DigitalOut(mbed_con, p9);

led0 = mbed.DigitalOut(mbed_con, p11);  %fixation led
led00 = mbed.DigitalOut(mbed_con, p12); %led for cue
led1 = mbed.DigitalOut(mbed_con, p13);  %next 4 green led's
led2 = mbed.DigitalOut(mbed_con, p14);
led3 = mbed.DigitalOut(mbed_con, p15);
led4 = mbed.DigitalOut(mbed_con, p16);
led5 = mbed.DigitalOut(mbed_con, p17); %next 4 red led's
led6 = mbed.DigitalOut(mbed_con, p18);
led7 = mbed.DigitalOut(mbed_con, p19);
led8 = mbed.DigitalOut(mbed_con, p20);
% Initialise experiment variables
commandwindow;
subject=input('Enter subject number, ex:sub1\n','s');
session=input('Enter session number, ex:sess1\n','s');
run=input('Enter run number, ex:run1\n','s');


% Start Eyelink

% Provide EyeLink with a window to perform initializations and later set
% parameters to be written in the EyeLink file

screenNumber=max(Screen('Screens'));
window=Screen('OpenWindow',screenNumber);
%

el=EyelinkInitDefaults(window);

if ~EyelinkInit(0, 1)
    fprintf('Eyelink Init aborted.\n');
    sca;
    Eyelink('Shutdown');
    return;
end

[~, vs]=Eyelink('GetTrackerVersion');
%[v,  vs]=Eyelink('GetTrackerVersion');
fprintf('Running experiment on a ''%s'' tracker.\n', vs );



 Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
 Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
 
 Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,GAZERES,AREA,HTARGET,STATUS,INPUT');
 Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,HREF,GAZERES,AREA,HTARGET,STATUS,INPUT');



% open file to record data to
EyelinkFileName=sprintf('%s%s',subject,run);
status = Eyelink('Openfile', [EyelinkFileName '.edf']);
if status ~= 0
    error('Could not open Eyelink file')
end

% Calibrate the eye tracker
EyelinkDoTrackerSetup(el);

% do a final check of calibration using drift correction
EyelinkDoDriftCorrection(el);



R2_onsets=[]; %Initialise timing file

trialNumber=0;

% Initialise button press check
% ListenChar(-1); % prevent spilling of keyboard output to console
KbName('UnifyKeyNames');

key_list=zeros(1,256);
bp_key=KbName('4$');

key_list(bp_key)=1; %set key to be detected as the number '1', the rest being set to 0
KbQueueCreate(-1,key_list);


%% Experiment control

array_VCO= [
    4,2,7,1;
    4,3,2,1;
    8,1,3,2;
    2,1,3,4;
    4,3,2,5;
    3,2,1,4;
    2,4,3,5;
    1,4,2,7;
    4,2,3,1;
    5,3,2,4;
    2,1,3,4;
    2,3,4,1;
    6,1,3,4;
    2,1,3,4];

    array_SCO=[
        3,4,6,1;
        2,1,4,3;
        7,1,2,4;
        2,1,4,3;
        2,1,8,3;
        1,3,4,2;
        3,1,6,4;
        1,4,3,2;
        4,7,2,1;
        3,2,4,5;
        3,4,2,1;
        3,1,4,2;
        7,2,4,1;
        2,4,1,3];

 input('Press enter to wait for trigger')   
    
% Detect first trigger to start experiment with
fprintf('Waiting for trigger\n')

trig_key=KbName('W');
while 1
    [~,~,KeyCode,~]=KbCheck(-1);
    
    
    if KeyCode(trig_key)
        break
    end
end
start_time=GetSecs; %start timer for experiment

    Eyelink('StartRecording');    % start recording from scanner

    Eyelink('Message', 'SYNCTIME');         % mark zero-plot time in data file


led0.write(1);

fprintf('Trigger received, 12 seconds before start of run\n');
WaitSecs(12);
KbQueueStart(-1); % start collecting button presses in the background


for i =1: size (array_VCO,1)
    
    
    % Visual counting trials
    
    % synchronise each block with trigger
    
    while 1
        [~,~,KeyCode,~]=KbCheck(-1);
        
        
        if KeyCode(trig_key)
            break
        end
    end
    fprintf('block trigger\n')
    
    
    
    for j=1:size(array_VCO,2)
        
        trialNumber = trialNumber+1;
        Eyelink('Message', sprintf('TRIAL %u', trialNumber));
        
        switch array_VCO(i,j)
            
            case 1
                fprintf('The onset time for VCO-led1 in block %d is %f seconds\n',i, GetSecs-start_time);
                led1.write(1);
                stim_time=GetSecs;
                WaitSecs(0.2);
                led1.write(0);
                WaitSecs(2);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;NaN NaN stim_onset NaN NaN];
                end
                continue
                
            case 2
                fprintf('The onset time for VCO-led2 in block %d is %f seconds\n',i, GetSecs-start_time);
                led2.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                led2.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;NaN NaN stim_onset NaN NaN];
                end
                continue
                
            case 3
                fprintf('The onset time for VCO-led3 in block %d is %f seconds\n',i, GetSecs-start_time);
                led3.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                led3.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;NaN NaN stim_onset NaN NaN];
                end
                continue
                
            case 4
                fprintf('The onset time for VCO-led4 in block %d is %f seconds\n',i, GetSecs-start_time);
                led4.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                led4.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;NaN NaN stim_onset NaN NaN];
                end
                continue
                
                
            case 5
                fprintf('The onset time for VCO-led5 in block %d is %f seconds\n',i, GetSecs-start_time);
                led5.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                led5.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 6
                fprintf('The onset time for VCO-led6 in block %d is %f seconds\n',i, GetSecs-start_time);
                led6.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                led6.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 7
                fprintf('The onset time for VCO-led7 in block %d is %f seconds\n',i, GetSecs-start_time);
                led7.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                led7.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 8
                fprintf('The onset time for VCO-led8 in block %d is %f seconds\n',i, GetSecs-start_time);
                led8.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                led8.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
        end
    end
    
    
    fprintf('ITI of 25 seconds\n');
    WaitSecs(25);  % Inter trial interval
    
    
 % Somatic counting trials
    
    % synchronise each block with trigger
        while 1
            [~,~,KeyCode,~]=KbCheck(-1);
            
            
            if KeyCode(trig_key)
                break
            end
        end
        fprintf('block trigger\n')
        
    
    
    for j= 1:size(array_SCO,2)
        
        trialNumber = trialNumber+1;
        Eyelink('Message', sprintf('TRIAL %u', trialNumber));
        
        switch array_SCO(i,j)
             case 1
                fprintf('The onset time for SCO-stim1 in block %d is %f seconds\n',i, GetSecs-start_time);
                stim1.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                stim1.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 2
                fprintf('The onset time for SCO-stim2 in block %d is  %f seconds\n',i, GetSecs-start_time);
                stim2.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                stim2.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 3
                fprintf('The onset time for SCO-stim3 in block %d is %f seconds\n',i, GetSecs-start_time);
                stim3.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.2);
                stim3.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 4
                fprintf('The onset time for SCO-stim4 in block %d is %f seconds\n',i, GetSecs-start_time);
                stim4.write(1);
                stim_time=GetSecs;
                WaitSecs(0.2);
                stim4.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;NaN 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
                
            case 5
                fprintf('The onset time for SCO-stim5 in block %d is %f seconds\n',i, GetSecs-start_time);
                stim1.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.05);
                stim1.write(0);
                WaitSecs(0.1);
                stim1.write(1) ;
                WaitSecs(0.05);
                stim1.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 6
                fprintf('The onset time for SCO-stim6 in block %d is %f seconds\n',i, GetSecs-start_time);
                stim2.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.05);
                stim2.write(0);
                WaitSecs(0.1);
                stim2.write(1) ;
                WaitSecs(0.05);
                stim2.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 7
                fprintf('The onset time for SCO-stim7 in block %d is %f seconds\n',i, GetSecs-start_time);
                stim3.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.05);
                stim3.write(0);
                WaitSecs(0.1);
                stim3.write(1) ;
                WaitSecs(0.05);
                stim3.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
            case 8
                fprintf('The onset time for SCO-stim8 in trial %d is %f seconds\n',i, GetSecs-start_time);
                stim4.write(1) ;
                stim_time=GetSecs;
                WaitSecs(0.05);
                stim4.write(0);
                WaitSecs(0.1);
                stim4.write(1) ;
                WaitSecs(0.05);
                stim4.write(0);
                WaitSecs(2.0);
                [pressed, firstPress, firstRelease, lastPress, lastRelease] = KbQueueCheck(-1);
                stim_onset=stim_time-start_time;
                if pressed
                    fprintf('button pressed\n')
                    bp_onset=firstPress(bp_key)-start_time;
                    RT=bp_onset-stim_onset;
                    R2_onsets=[R2_onsets;1 1 stim_onset bp_onset RT];
                else
                    R2_onsets=[R2_onsets;1 NaN stim_onset NaN NaN];
                end
                continue
                
                
        end
        
    end
    fprintf('ITI of 25 seconds\n');
    WaitSecs(25);  % Inter trial interval
end
%     end
%     end


%% experiment ending routine

led0.write(0); %turn off fixation LED
KbQueueStop(-1); % stop accepting button presses
KbQueueRelease(-1); % release keyboard
% ListenChar(0); % restore keyboard state
Eyelink('Command', 'set_idle_mode');
fprintf('End of Run\n');
% save Eyelink and onset files

savePath=(fullfile('E:\USERS\Nikhil',subject,session));
mkdir(savePath);

R2_onsets = array2table(R2_onsets,'VariableNames',{'odd_trial','bp','stim_onset','bp_onset','RT'});

save(fullfile(savePath,'R2_onsets'),'R2_onsets');
fprintf('saved onset file in the specified folder')

            Eyelink('StopRecording');
            Eyelink('CloseFile');

            % download data file
            try
                fprintf('Receiving data file ''%s''\n',EyelinkFileName );
                status=Eyelink('ReceiveFile', EyelinkFileName, savePath);
                if status > 0
                    fprintf('ReceiveFile status %d\n', status);
                end
                if 2==exist(fullfile(savePath,EyelinkFileName), 'file')
                    fprintf('EyeLink file ''%s'' can be found in ''%s''\n', EyelinkFileName, savePath );
                end
            catch rdf
                fprintf('Problem receiving data file ''%s''\n',EyelinkFileName);
                rdf;
            end
%             Eyelink('Shutdown');
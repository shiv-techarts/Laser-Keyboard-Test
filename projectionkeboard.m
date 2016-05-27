%
% Name: Shiv Pratap Singh
%
% Program: Projection Calculator KeyPad
%
% This is a Combined code of MATLAB and JAVA to make motion of keyboard keys based on object detected using image Projection and Detection.
% All values of XVal and YVal is to be feed manually according to the projection or image detection size.

%% Initialization

import java.awt.Robot;
import java.awt.event.*;

KeyP = Robot();

aFlag = 0;

XVal = 0;
YVal = 0;

%==================================================%

XColOneMin = 100;
XColOneMax = 195;

XColTwoMin = 210;
XColTwoMax = 275;

XColThreeMin = 290;
XColThreeMax = 360;

XColFourMin = 380;
XColFourMax = 440;

YRowOneMin = 275;
YRowOneMax = 300;

YRowTwoMin = 235;
YRowTwoMax = 265;

YRowThreeMin = 175;
YRowThreeMax = 225;

YRowFourMin = 125;
YRowFourMax = 170;

YRowFiveMin = 85;
YRowFiveMax = 125;

%==================================================%




redThresh = 0.25; % Threshold for red laser point detection
vidDevice = imaq.VideoDevice('winvideo', 1,'YUY2_640x480', ... % Acquire input video stream from camera, Change according to your camera port
                    'ROI', [1 1 640 480], ...
                    'ReturnedColorSpace', 'rgb');
vidInfo = imaqhwinfo(vidDevice); % Acquire input video property
hblob = vision.BlobAnalysis('AreaOutputPort', false, ... % Set blob analysis handling
                                'CentroidOutputPort', true, ... 
                                'BoundingBoxOutputPort', true', ...
                                'MinimumBlobArea', 800, ...
                                'MaximumBlobArea', 3000, ...
                                'MaximumCount', 10);
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'Custom', ... % Set Red box handling
                                        'CustomBorderColor', [1 0 0], ...
                                        'Fill', true, ...
                                        'FillColor', 'Custom', ...
                                        'CustomFillColor', [1 0 0], ...
                                        'Opacity', 0.4);
htextins = vision.TextInserter('Text', 'Number of Red Object: %2d', ... % Set text for number of blobs detected
                                    'Location',  [7 2], ...
                                    'Color', [1 0 0], ... // red color
                                    'FontSize', 12);
htextinsCent = vision.TextInserter('Text', '+      X:%4d, Y:%4d', ... % set text for centroid
                                    'LocationSource', 'Input port', ...
                                    'Color', [1 1 0], ... // yellow color
                                    'FontSize', 14);
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ... % Output video player
                                'Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);
nFrame = 1; % Frame number initialization

%% Processing Loop
while(nFrame)
    rgbFrame = step(vidDevice); % Acquire single frame
    rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying
    diffFrame = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); % Get red component of the image
    diffFrame = medfilt2(diffFrame, [3 3]); % Filter out the noise by using median filter
    binFrame = im2bw(diffFrame, redThresh); % Convert the image into binary image with the red objects as white
    [centroid, bbox] = step(hblob, binFrame); % Get the centroids and bounding boxes of the blobs
    centroid = uint16(centroid); % Convert the centroids into Integer for further steps 
    rgbFrame(1:20,1:165,:) = 0; % put a black region on the output stream
    vidIn = step(hshapeinsRedBox, rgbFrame, bbox); % Insert the red box
    
    hold on
    
    for object = 1:1:length(bbox(:,1)) % Write the corresponding centroids
        centX = centroid(object,1); centY = centroid(object,2);
        vidIn = step(htextinsCent, vidIn, [centX centY], [centX-6 centY-9]); 

%====================================================================================================================%


        XVal = centroid(object,1);
        YVal = centroid(object,2);
        if(aFlag == 0 && XVal && YVal)
            
			aFlag = 1;
            %--------------------------------------------------------------------%
            if((XVal >= XColOneMin && XVal <=XColOneMax) && (YVal >= YRowOneMin && YVal <= YRowOneMax))
            	KeyP.keyPress(KeyEvent.VK_ESCAPE);
				KeyP.keyRelease(KeyEvent.VK_ESCAPE);
            elseif((XVal >= XColTwoMin && XVal <=XColTwoMax) && (YVal >= YRowOneMin && YVal <= YRowOneMax))
            	
            elseif((XVal >= XColThreeMin && XVal <=XColThreeMax) && (YVal >= YRowOneMin && YVal <= YRowOneMax))
            	KeyP.keyPress(KeyEvent.VK_BACK_SPACE);
				KeyP.keyRelease(KeyEvent.VK_BACK_SPACE);
            elseif((XVal >= XColFourMin && XVal <=XColFourMax) && (YVal >= YRowOneMin && YVal <= YRowOneMax))
            	
            %--------------------------------------------------------------------%
            
            elseif((XVal >= XColOneMin && XVal <=XColOneMax) && (YVal >= YRowTwoMin && YVal <= YRowTwoMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD7);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD7);
            elseif((XVal >= XColTwoMin && XVal <=XColTwoMax) && (YVal >= YRowTwoMin && YVal <= YRowTwoMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD8);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD8);
            elseif((XVal >= XColThreeMin && XVal <=XColThreeMax) && (YVal >= YRowTwoMin && YVal <= YRowTwoMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD9);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD9);
            elseif((XVal >= XColFourMin && XVal <=XColFourMax) && (YVal >= YRowTwoMin && YVal <= YRowTwoMax))
            	KeyP.keyPress(KeyEvent.VK_DIVIDE);
				KeyP.keyRelease(KeyEvent.VK_DIVIDE);
            %--------------------------------------------------------------------%
            
            elseif((XVal >= XColOneMin && XVal <=XColOneMax) && (YVal >= YRowThreeMin && YVal <= YRowThreeMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD4);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD4);
            elseif((XVal >= XColTwoMin && XVal <=XColTwoMax) && (YVal >= YRowThreeMin && YVal <= YRowThreeMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD5);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD5);
            elseif((XVal >= XColThreeMin && XVal <=XColThreeMax) && (YVal >= YRowThreeMin && YVal <= YRowThreeMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD6);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD6);
            elseif((XVal >= XColFourMin && XVal <=XColFourMax) && (YVal >= YRowThreeMin && YVal <= YRowThreeMax))
            	KeyP.keyPress(KeyEvent.VK_MULTIPLY);
				KeyP.keyRelease(KeyEvent.VK_MULTIPLY);
            %--------------------------------------------------------------------%
            
            elseif((XVal >= XColOneMin && XVal <=XColOneMax) && (YVal >= YRowFourMin && YVal <= YRowFourMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD1);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD1);
            elseif((XVal >= XColTwoMin && XVal <=XColTwoMax) && (YVal >= YRowFourMin && YVal <= YRowFourMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD2);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD2);
            elseif((XVal >= XColThreeMin && XVal <=XColThreeMax) && (YVal >= YRowFourMin && YVal <= YRowFourMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD3);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD3);
            elseif((XVal >= XColFourMin && XVal <=XColFourMax) && (YVal >= YRowFourMin && YVal <= YRowFourMax))
            	KeyP.keyPress(KeyEvent.VK_SUBTRACT);
				KeyP.keyRelease(KeyEvent.VK_SUBTRACT);
            %--------------------------------------------------------------------%
                
            elseif((XVal >= XColOneMin && XVal <=XColOneMax) && (YVal >= YRowFiveMin && YVal <= YRowFiveMax))
            	KeyP.keyPress(KeyEvent.VK_NUMPAD0);
				KeyP.keyRelease(KeyEvent.VK_NUMPAD0);
            elseif((XVal >= XColTwoMin && XVal <=XColTwoMax) && (YVal >= YRowFiveMin && YVal <= YRowFiveMax))
            	KeyP.keyPress(KeyEvent.VK_DECIMAL);
				KeyP.keyRelease(KeyEvent.VK_DECIMAL);
            elseif((XVal >= XColThreeMin && XVal <=XColThreeMax) && (YVal >= YRowFiveMin && YVal <= YRowFiveMax))
            	KeyP.keyPress(KeyEvent.VK_ENTER);
				KeyP.keyRelease(KeyEvent.VK_ENTER);
            elseif((XVal >= XColFourMin && XVal <=XColFourMax) && (YVal >= YRowFiveMin && YVal <= YRowFiveMax))
            	KeyP.keyPress(KeyEvent.VK_ADD);
				KeyP.keyRelease(KeyEvent.VK_ADD);
            %--------------------------------------------------------------------%
            
            else
                aFlag = aFlag + 1;
            end
            aFlag = 0;
                
        end
        
        
%===================================================================================================================%        
        
    end
    vidIn = step(htextins, vidIn, uint8(length(bbox(:,1)))); % Count the number of blobs
    
    step(hVideoIn, vidIn); % Output video stream
    %nFrame = nFrame+1;
	pause(.07); % pause for a duration
            
    hold off
end
%% Clearing Memory
release(hVideoIn); % Release all memory and buffer used
release(vidDevice);
% clear all;
clc;
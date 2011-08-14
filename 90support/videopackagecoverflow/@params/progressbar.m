% ==============================================================
%
%    GENERAL
%
%
%    INPUT/S
%   
%        
%    OUTPUT/S
%
%      -
%
%    PENDING WORK
%
%      -
%
%    KNOWN BUG/S
%
%      -
%
%    COMMENT/S
%
%      -
%
%    RELATED FUNCTION/S
%
%      
%
%    ABOUT
%
%      -Created:     November 2003
%      -Last update: 
%      -Revision:    0.3.1
%      -Author:      R. S. Schestowitz, University of Manchester
% ==============================================================

% Instructions: follow the three simple steps below -- (1), (2) and (3)

function progressbar(obj,i,max,time_for_this_iteration,title)
          % (1) Set this to the total number of iterations
           if (obj.release)
               clc;
               i = double(i);
               max = double(max);
               progress_bar_position = i / max;
               fprintf('%s\n',title);

               disp(['|=================================================|']);
               progress_string='|';       
               for counter = 1:floor(progress_bar_position * 100 / 2),
                   progress_string = [progress_string, '#'];
               end
               disp(progress_string);
               disp(['|================= ',num2str(floor(progress_bar_position*100)),'% completed =================|']);
                              % display progress per cent
               steps_remaining = max - i;
               minutes = floor(time_for_this_iteration * steps_remaining / 60);
               seconds = rem(floor(time_for_this_iteration *  steps_remaining), 60);
               disp(' ');
               if (seconds > 9),
                 disp(['            Estimated remaining time: ', num2str(minutes), ':', num2str(seconds)]);
                              % show time indicators
               else
                 disp(['            Estimated remaining time: ', num2str(minutes), ':0', num2str(seconds)]);
               end
           else
               fprintf('%s\n',title);
           end
         
end

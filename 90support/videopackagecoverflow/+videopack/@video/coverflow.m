function [w, h] = coverflow(obj, p, frames)
% visualizes some frames
% frames [startat : step : stopat]
   
   w = figure; hold on; set(w,p.cflowwindow);                         % set up window
   h = zeros(size(frames));                                                              % handles for every surf
   warning off all;                                                     % we use smaller surfs than texture     

   for i=frames
       d = zeros(obj.info.Height/100, obj.info.Width/100);              %smaller surf for performance
       d(:) = i;                                                     % z value = frame number
       h(i) = surf(d, obj.movie(i).cdata, 'FaceAlpha',1-(i/max(frames)));                %draw and map
       set(h(i),p.cflowproperties);                                   % set global surfproperties
   end

   warning on all;
   view([1,1,1]);
   %hold off;
end
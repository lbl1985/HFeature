function [w, h] = coverflow(obj, p, frames)
    % visualizes some frames
    % frames [startat : step : stopat]

    w = figure; hold on; set(w,p.cflowwindow);                         % set up window
    h = zeros(size(frames));                                                              % handles for every surf
    warning off all;                                                     % we use smaller surfs than texture

    for i=frames
        %        d = zeros(obj.info.Height/100, obj.info.Width/100);              %smaller surf for performance
        d = zeros(obj.info.Height, obj.info.Width);
        d(:) = i*3;                                                     % z value = frame number
        h(i) = surf(d, obj.movie(i).cdata, 'FaceAlpha',1-(i/max(frames)));                %draw and map
%         h(i) = surf(d, obj.movie(i).cdata);
        set(h(i),p.cflowproperties);                                   % set global surfproperties
    end
    
    hold off
    warning on all;
    view(3);
    rotate(h(:), [1 0 0], -90);
    
end
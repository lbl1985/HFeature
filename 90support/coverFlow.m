function [w, h] = coverFlow(movie, p, frames, varargin)
    % visualizes some frames
    % frames [startat : step : stopat]
    if nargin < 4,  w = figure;   
    else w = figure(varargin{1});   delete(w);
    end
    hold on; set(w,p.cflowwindow);                         % set up window
    h = zeros(size(frames));                                                              % handles for every surf
    warning off all;                                                     % we use smaller surfs than texture

    for i= 1 : length(frames)
        %        d = zeros(obj.info.Height/100, obj.info.Width/100);              %smaller surf for performance
        d = zeros(size(movie(1).cdata, 1), size(movie(1).cdata, 2));
        d(:) = i*3;                                                     % z value = frame number
%         h(i) = surf(d, obj.movie(frames(i)).cdata, 'FaceAlpha',1-(i/length(frames)));                %draw and map
        h(i) = surf(d, movie(i).cdata);
        set(h(i),p.cflowproperties);                                   % set global surfproperties
    end
    
    hold off
    warning on all;
    view(3);
    rotate(h(:), [1 0 0], -90);
    
end
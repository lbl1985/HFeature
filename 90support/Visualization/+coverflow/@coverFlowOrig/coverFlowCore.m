function [w, h] = coverFlowCore(obj, movie)
    % visualizes some frames
    % frames [startat : step : stopat]
    w = figure(obj.figHandel);    clf(w);    
    p = obj.param;  frames = obj.frames;
    
    hold on; set(w,p.cflowwindow);                         % set up window
    h = zeros(size(frames));                                                              % handles for every surf
    warning off all;                                                     % we use smaller surfs than texture
    ndim = ndims(movie);
    nFrameLen = length(frames);
    siz = size(movie);
    for i= 1 : nFrameLen
        %        d = zeros(obj.info.Height/100, obj.info.Width/100);              %smaller surf for performance
        d = zeros(siz(1), siz(2));
        d(:) = i;                                                     % z value = frame number
%         h(i) = surf(d, obj.movie(frames(i)).cdata, 'FaceAlpha',1-(i/length(frames)));                %draw and map
        if ndim == 4 
            h(i) = surf(d, movie(:, :, :, frames(nFrameLen - i + 1)));
        else
            h(i) = surf(d, movie(:, :, frames(nFrameLen - i + 1)));
        end
        set(h(i),p.cflowproperties);                                   % set global surfproperties        
    end
    
    title(['Frame ' num2str(frames(1))]);
    
    hold off
    warning on all;
    rotate(h(:), [1 0 0], -90);
    % stackSize = 5;
    az = -75; el = 30;
    view(az, el);
    
end
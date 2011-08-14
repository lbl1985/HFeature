function play(obj, p, loop, fps, mov)
% plays video in window
% which is configured in the constructor
% using standard movie() function
   
    if nargin<2
        p = params();
       fprintf('Using standard parameters.\n');
   end
   
   if nargin<5
       mov = obj.movie;
   end

   if nargin<3
       loop=255;
   end

   if nargin<4
       fps=12; % easy Frank, easy...
   end
   
   if (p.showframes)
       mov = obj.mapframenumbers(mov);       
   end
   
   h = figure;
   set(h,p.playwindow);
   movie(h,mov,loop, fps);
end

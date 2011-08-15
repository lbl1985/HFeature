classdef video 
%VIDEO base object

   properties (SetAccess = public, GetAccess = public)
       name = 'Sugar Babes';
       videofile = 'sugar.avi';
       movie = struct;            % actual movie data MATLAB mov cell array
                                            % index is frame number
       info = struct;               % aviinfo result
   end
   
   properties (SetAccess = private, GetAccess = public, Dependent = true)
       nframes;           %number of frames
   end
   
   properties (SetAccess = private, GetAccess = private)
   end

   methods
       % basic constructor
       function obj = video(file, p)
           if (nargin==0)
               return;
           end
           
           obj.videofile = file;
           obj.name = file;
                     
           obj = readframes(obj, p);
           
       end
       
       function obj = set.name(obj,value)
           if ~(ischar(value))
               error('video name must be a string but is: %s', value)
           else
               obj.name = value;
           end
       end
       
       function n = get.nframes(obj)
           n = uint32(size(obj.movie,2));
       end
   end
   
   methods (Access = public)
       % plays video in window
       play(obj, p, loop, fps, mov)
       
       % writes frame images and video using ffmpeg
       writevideo(obj, p, file, video, fps)
       
       % visualizes some frames
       % frames [startat : step : stopat]
       [w h] = coverflow(obj, p, frames);
       
       % converts a 3dim matrix (e.g. energy) into a 
       % MATLAB movie and vice versa
       obj = matrix2movie(obj, p, m)
       
       matrix = movie2matrix(obj, p)
       
       mov = mapframenumbers(obj,mov)
       
   end
 
   methods (Access = private)
        obj = readframes(obj,p)
        %%
        % encodes frame images and loads it into matrix
       
        imtext = text2im(obj, text)
        % generates an image, containing the input text
        
        newim = implace(obj, im1, im2, roff, coff)
        % place image at specified location within larger image
   end
end

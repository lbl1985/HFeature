function obj = readframes(obj,p)
   % encodes frame images from any video using ffmpeg
   % (must be installed and accessible from the path!)
   % and loads it into movie.cdata matrix
   
   %first, writes frames as images to /tmp/cputime, then deletes it again
   if (nargin<2)
       p = tools();
       if ~p.release
           fprintf('Using standard parameters.\n');
       end
   end;
   
   hash = [p.tmpdir 'sffmpegtmpin' num2str(cputime) '/'];
   mkdir(hash);
   fprintf('%s\n created.\n',hash); % we store tmp frames in dir with hash name.
   
   % generates frame pics
   %converterbinary = '/opt/local/bin/ffmpeg';
    %converterbinary = '/Applications/ffmpegX.app/Contents/Resources/ffmpeg';
    
   switch p.converter
       case 'ffmpeg'   
           if strcmp(computer,'MACI')
                    if ~p.release
                        fprintf(['You are running an Intel Mac\n I will encode frames into ' p.picformat '\n']);
                    end
                    if ~(strcmp(p.converterbinary,'standard'))
                        command = [p.converterbinary ' -i ' p.videodir obj.videofile ' ' hash obj.videofile '%09d.' p.picformat];
                    else
                        command = ['/Applications/ffmpegX.app/Contents/Resources/ffmpeg -i ' p.videodir obj.videofile ' ' hash obj.videofile '%09d.' p.picformat];
                    end
           end
           if strcmp(computer,'GLNXA64')
                    if (p.converterbinary~='standard')
                        command = [p.converterbinary ' -i ' p.videodir obj.videofile ' -f image2 ' hash obj.videofile '%09d.' p.picformat];
                    else
                        command = ['ffmpeg -i ' p.videodir obj.videofile ' -f image2 ' hash obj.videofile '%09d.' p.picformat];
                    end
           end
           if strcmp(computer,'PCWIN')
                    error('You are running Windows? This is not implemented yet.');
           end
           
           fprintf('Invoking %s ...\n',command);
           call = unix(command);
           
       case 'mencoder'
           error('mencoder is not integrated in this software yet. sorry.');
       %case '/opt/local/bin/ffmpeg'
       %    command = [p.converterbinary ' -i ' p.videodir obj.videofile ' -f image2 ' hash obj.videofile '%09d.' p.picformat];
   end
   
   %command = ['binaries/ffmpeg/ffmpeg -i ' p.videodir obj.videofile ' -f image2 ' hash obj.videofile '%09d.bmp'];
   
   
   
   if (call == 127)      %invoking ffmpeg
       %warning('ffmpeg''s not properly installed. Mac? I''ll try /Applications/ffmpegX.app/Contents/Resources/ffmpeg');
       error('chosen video converter not found. Adjust converter parameter.');
       %command = ['/Applications/ffmpegX.app/Contents/Resources/ffmpeg -i ' p.videodir obj.videofile ' ' hash obj.videofile '%09d.' p.picformat];
       %fprintf('Invoking %s ...\n',command);
       %call = unix(command);
   end

   %reads frames into 4 dim matrix
   frames = dir([hash '*.' p.picformat]);
   
   if (p.splitVideo)
       if ~(p.release)
           fprintf('I am splitting video and using frames %i to %i.\n',p.startframe,p.endframe);
       end
       try
            frames = frames(p.startframe:p.endframe);
       catch ME
           error('Unable to split video. Maybe video too short?');
       end
   end
   
   tmp = struct;
   l = size(frames,1);
   for i=1:l %parfor does not allow object properties
       tic
       tmp(i).cdata = imread([hash frames(i).name]);
       tmp(i).colormap = colormap(p.colormap);
       if ~p.release
           if (mod(i,25)==0)
                fprintf('Reading frame %i/%i\n',i,l);
           end
        %p.progressbar(l-i,l,toc,title);       
       end
   end
   obj.movie = tmp;
   fprintf('done.\n.');

   %remove frames
   rmdir(hash,'s');
   fprintf('%s\n removed.\n',hash);

   %some info & checks
   try
    obj.info = aviinfo([p.videodir obj.videofile]);
   catch
       warning('No proper avi loaded. No aviinfo!');
   end
   
   if (size(obj.movie(1).cdata,3)==1)
       fprintf('Single channel video, we triple the channel to three dims...\n');
       for i= 1:size(obj.movie,2)
            obj.movie(i).cdata = repmat(obj.movie(i).cdata,[1 1 3]);
       end
   end
   
   try
   if [obj.info.Height obj.info.Width]~= [size(obj.movie(1).cdata,1) size(obj.movie(1).cdata,2)]
       fprintf('aviinfo: %i %i %i, frames: %i %i %i\n', ...
               [obj.info.Height obj.info.Width 3],...
               size(obj.movie(1).cdata));
       error('Wrong dimension in movie data!\n');
   end
   catch
   end
end

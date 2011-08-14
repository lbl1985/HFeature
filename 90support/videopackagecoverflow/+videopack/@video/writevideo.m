function writevideo(obj, p, file, video, fps)
% writes frame images and video
% using ffmpeg

   if nargin<3
       file = [p.outputdir p.name p.outputfile '.avi'];
   end
   
   if nargin<4
      video = obj.movie;
   end
   
   if nargin<5
       fps = 12;
   end
   
   if (p.showframes)
       video = obj.mapframenumbers(video);       
   end
   
   % working dir
   hash = ['/tmp/ffmpegtmpout' num2str(cputime) '/'];
   mkdir(hash);
   fprintf('%s\n created.\n',hash);

   %write frame images
   %tmp = video;
   filetmp = obj.videofile;
   
   for i=1:size(video,2)
       imwrite(video(i).cdata, sprintf('%s%s%09i.bmp',hash,filetmp,i),'BMP');
   end

   if strcmp(computer,'GLNXA64')
        command = ['ffmpeg -y -r ' num2str(fps) ' -i ' hash obj.videofile '%9d.bmp ' file];
   end
   if strcmp(computer,'MACI')
        command = ['/Applications/ffmpegX.app/Contents/Resources/ffmpeg -y -r ' num2str(fps) ' -i ' hash obj.videofile '%9d.bmp ' file];
   end
   
   fprintf('%s\n',command);
   unix(command);
   % remove frames
   rmdir(hash,'s');
   fprintf('%s\n removed.\n',hash)
end

function mov = mmreader2mmread(file)
video = mmreader(file);

nFrames = video.NumberOfFrames;
vidHeight = video.Height;
vidWidth = video.Width;

mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), ...
    'colormap', []);

for k = 1 : nFrames
    mov(k).cdata = read(video, k);
end

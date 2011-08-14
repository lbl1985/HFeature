function matrix = movie2matrix(obj, p)

%fprintf('this function is not tested!');

frames = size(obj.movie,2);

[height width depth] = size(obj.movie(1).cdata);

matrix = zeros(height, width, frames*depth);

for i = 1:frames
    pos = (i-1) * depth+ 1;
    %try
        matrix(:,:,pos:pos+depth-1) = obj.movie(i).cdata(1:height,1:width,1:depth);
    %catch
    %    warning('frame nr. %i not converted properly',i);
    %end
end
% converts a 3dim matrix (e.g. energy) into a 
% MATLAB movie
function obj = matrix2movie(obj, p, m)
% 
% if (size(size(m),2)~=3)
% 	error('Matrix is not in MxNxframes dimensionality.');
% end
	
%mov = struct;
frames = uint32(size(m,3)/3);

%bring matrix into uint8 range
m = m - min(min(min(m)));
m = m./max(max(max(m)));
m = uint8(m.*255);

for i=1:frames
    pos = (i-1) * 3 + 1;
% 	obj(i).cdata = repmat(m(:,:,pos:pos+depth-1),[1 1 3]);
    obj.movie(i).cdata = m(:,:,pos:pos+2);
	obj.movie(i).colormap = p.colormap;
end
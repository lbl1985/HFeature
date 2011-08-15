%Author: Julian Stoettinger
%check out: www.prip.tuwien.ac.at/julian

p = params();
% optional parameter adjustment -> help params
p.splitVideo = true;
p.startframe = 1;
p.endframe = 10;
p.picformat = 'jpg';

v = videopack.video('test.avi',p);
% v.play
v.coverflow(p,1:6); %fancy coverflow visualization
v.writevideo(p);
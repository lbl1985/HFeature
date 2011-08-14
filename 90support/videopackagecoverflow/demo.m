%Author: Julian Stoettinger
%check out: www.prip.tuwien.ac.at/julian

p = params();
% optional parameter adjustment -> help params
p.splitVideo = true;
p.startframe = 12;
p.endframe = 18;
p.picformat = 'jpg';

v = videopack.video('test.avi',p);
v.play
v.coverflow(p,1:6); %fancy coverflow visualization
v.writevideo(p);
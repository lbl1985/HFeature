%Author: Julian Stoettinger
%check out: www.prip.tuwien.ac.at/julian

p = params();
% optional parameter adjustment -> help params
p.splitVideo = true;
p.startframe = 1;
p.endframe = 200;
p.stackSize = 3;
p.picformat = 'jpg';


v = videopack.video('test.avi',p);
% v.play

for i = p.startframe : p.endframe - p.stackSize + 1    
    v.coverflow(p, i : i + p.stackSize -1); %fancy coverflow visualization
    pause(1/11);
    close(gcf);
end
% v.writevideo(p);
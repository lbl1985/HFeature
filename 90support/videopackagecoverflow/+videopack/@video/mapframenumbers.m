function mov = mapframenumbers(obj, mov)

   frames = size(mov,2);
   [height width depth] = size(mov(1).cdata);

   for i=1:frames
    frameim = obj.text2im(num2str(i))*255; 
    mov(i).cdata = obj.implace(mov(i).cdata, frameim, 0,0);
   end
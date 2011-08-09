% myfolder = '/Users/herbert19lee/Documents/MATLAB/work/HFeature';
myfolder = which('main_control.m');
myfolder = myfolder(1:strfind(myfolder, 'main_control.m') - 1);
master_train(fullfile(myfolder, 'AVIClips05/'), fullfile(myfolder, '10digging'));
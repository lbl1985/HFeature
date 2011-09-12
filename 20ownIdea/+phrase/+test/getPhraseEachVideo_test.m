function getPhraseEachVideo_test
M = (1:10)';
f.numFeaturePerFrame = 2;
phraseWindowSize = 3;

calMatrix = phrase.getPhraseEachVideo(M, f, phraseWindowSize);
answerMatrix = [(1:6)' (3:8)' (5:10)'];
assert(isequal(calMatrix, answerMatrix), 'phrase.getPhraseEachVideo function is broken.');
function testPhraseLabelAll = assignTestingLabel_phrase(trainCenterAll, testPhraseFeatureAll, params)

for i = 1 : params.num_km_init_word
    for j = 1 : params.num_km_init_phrase
        testPhraseLabelAll{1, i}{j, 1} = find_labels_dnc(trainCenterAll{1, i}{j, 1}, testPhraseFeatureAll{i});
    end
end

% save(fullfile(dataFolder, 'phraseTest.mat'), 'testPhraseFeatureAll', ...
%     'testPhraseIndices', 'testPhraseLabelAll', 'MM_test_phrase');
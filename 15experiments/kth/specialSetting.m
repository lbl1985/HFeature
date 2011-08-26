function [train, test] = specialSetting(groupsLabel)
Types = unique(groupsLabel);
nType = length(Types);
TestObjects = [2 3 5 6 7 8 9 10 22];
% TestObjects = [1 4 11 : 21 23 : 25];
test = zeros(length(groupsLabel), 1);
% How many identities for each type.
TypeLength = zeros(1, nType);
for i = 1 : length(Types)
    TypeLength(i) = length(find(groupsLabel == Types(i)));
end
TypeLength = [0 TypeLength(1 : end - 1)];
CumTypeLength = cumsum(TypeLength);
testIdx = [];
for i = 1 : nType
    % For kth Original
%     TypeDragging = Types(i);
    for j = 1 : length(TestObjects)
        ObjectDragging = TestObjects(j);
        midIdx = ((ObjectDragging - 1) * 4 + 1 : (ObjectDragging - 1) * 4 + 4);
        % For kth Original
%         if mod(length(groupsLabel), 100) ~= 0
%             if TypeDragging == 1 && ObjectDragging >= 13
%                midIdx = midIdx - 1; 
%             end
%         end
        % for kth 99
        if ObjectDragging >= 13
            midIdx = midIdx - 1;
        end
        midIdx = midIdx + CumTypeLength(i);
        testIdx = cat(2, testIdx, midIdx);
    end
end
test(testIdx) = 1;
train = ~test;
test = ~train;
function arrayData = assembleCellData2Array(cellData, dim)
arrayData = [];
for i = 1 : length(cellData)
    arrayData = cat(dim, arrayData, cellData{i});
end
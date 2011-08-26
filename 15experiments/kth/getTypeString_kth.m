function type = getTypeString_kth(typeId)
    switch num2str(typeId)
        case '1'
            type = 'boxing';
        case '2'
            type = 'handclapping';
        case '3'
            type = 'handwaving';
        case '4'
            type = 'jogging';
        case '5'
            type = 'running';
        case '6'
            type = 'walking';
    end
end
function [info_matrix] = write_stats(info_matrix,data,i,maxv,startv,endv,title,save)

    info_matrix(i,1) = i-1; % event number
    info_matrix(i,2) = startv; % event start time period
    info_matrix(i,3) = endv; % event end time period
    info_matrix(i,4) = max(data); % event maximum
    info_matrix(i,5) = min(data); % event minimum
    info_matrix(i,6) = mean(data); % event mean
    
    classification = 0;
    if max(data) > 100
        classification = 1;
    end
    
    info_matrix(i,7) = classification; % event classification
    
    if i == maxv-1 && save == 1
        writematrix(info_matrix,"class/"+title+".csv");
    end
    
end
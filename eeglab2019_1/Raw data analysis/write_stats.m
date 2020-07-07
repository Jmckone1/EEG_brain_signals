function [info_matrix] = write_stats(info_matrix,data,i,maxv,startv,endv,title)

    info_matrix(i,1) = i;
    info_matrix(i,2) = startv;
    info_matrix(i,3) = endv;
    info_matrix(i,4) = max(data);
    info_matrix(i,5) = min(data);
    info_matrix(i,6) = mean(data);
    
    if i == maxv-1
        writematrix(info_matrix,"class/"+title+".csv");
    end
    
end
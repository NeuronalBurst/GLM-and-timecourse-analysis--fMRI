fileId=fopen('CoolTerm.txt');
line=fgetl(fileId);
line=fgetl(fileId);
n=1;
 while ~feof(fileId)
%     for i=1:3
% line1=fgetl(fileId);
% tim_data(1,1)=textscan(line1,'%*s %*s %*s %*s %*s %*s %*d %*s %f %*s');
% line2=fgetl(fileId);
% tim_data(1,2)=textscan(line2,'%*s %*s %*s %f %*s');
% line3=fgetl(fileId);
% tim_data(1,3)=textscan(line3,'%*s %*s %*s %*s %f %*s');
line=fgetl(fileId);
tim_data(n,:)=textscan(line,'%f');
n=n+1;



% if startsWith(line,'NA')
%    tim_data(n,:)=textscan(line,'%*s %f %f %f','Delimiter', ',');
%    n=n+1;
% 
% elseif startsWith(line,'bpL')
%     bp_line(m,1)=n;
%     m=m+1;
%     tim_data(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');
%     n=n+1;
% else
%     tim_data(n,:)=textscan(line,'%f %f %d %*s','Delimiter', ',');
%     n=n+1;
% end
%         end
     end 

fclose(fileId);
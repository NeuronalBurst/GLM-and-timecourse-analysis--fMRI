fileId=fopen('/p/himmelbach/nikhil/timing_files/sub2/sess3/TIM_R4.rtf');
fgetl(fileId);
% fgetl(fileId);
n=1;
m=1;
temp_time4=zeros(112,2);
while ~feof(fileId)
line=fgetl(fileId);
if startsWith(line,'NA')
   temp_time4(n,1)=cell2mat(textscan(line,'%*s %f'));
%    temp_time4(n,:)=textscan(line,'%*s %f %f','Delimiter', ',');

   n=n+1;

elseif startsWith(line,'bpL')
    bp_trial(m,1)=n;
    m=m+1;
    
    temp_time4(n,:)=cell2mat(textscan(line,'%*s %f %f'));
%     temp_time4(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');

    n=n+1;
else
    temp_time4(n,1)=cell2mat(textscan(line,'%f'));
%         temp_time4(n,:)=textscan(line,'%f %f','Delimiter', ',');

    n=n+1;
end
end
fclose(fileId);
fid=fopen('CoolTerm Capture 2018-02-21 11-12-41.txt');
key='is';
values=num2cell(zeros(112,3));

ind=1:4:351/3; % since every 12th row needs to be deleted

n=1;
m=2;
while ~feof(fid)
    
    line1=fgetl(fid);
index1=strfind(line1,key);
values{n,1}=sscanf(line1(index1+length(key):end), '%f', 1);
    line2=fgetl(fid);
index2=strfind(line2,key);
values{n,2}=sscanf(line2(index2+length(key):end), '%f', 1);
    line3=fgetl(fid);
index3=strfind(line3,key);
values{n,3}=sscanf(line3(index3+length(key):end), '%f', 1);

n=n+1;
if n==ind(m)
    fgetl(fid);
    m=m+1;
end
end

values(2:end+1,:)=values(1:end,:);
values{1,1}='onsets';
values{1,2}='RT';
values{1,3}='trial_dur';

 fid = fopen('TIM_R1.CSV','w');
  fprintf(fid,'%s,%s,%s\n',values{1,:});
  for a=2:length(values)
  fprintf(fid,'%f,%f,%f\n',values{a,:});
  end
  fclose(fid);



paired_ratio = 0.9;
datadir='/data/';
dataname = '2V_Hdigit.mat';
datafile = [datadir, cell2mat(dataname)];
load(datafile); 
gt = truelabel;
cls_num = length(unique(truelabel));
view_num = length(data);
for i = 1:view_num
    eval(['X_view',num2str(i),'=data{',num2str(i),'};']);
    eval(['X_view',num2str(i),'_all=data{',num2str(i),'};']);
end
inc_rate = ones(1,view_num)/view_num; 
tempN = floor(sample_num*(1-paired_ratio));
inc_index = randperm(sample_num, floor(sample_num*(1-paired_ratio)));
tempM = 1:tempN;
index = {};
data = {};
for i = 1:view_num
    tempI = randperm(tempN, floor(sample_num*(1-paired_ratio)*inc_rate(i)));
    eval(['inc_index',num2str(i),'=inc_index(tempM(tempI));']);
    tempM = setdiff(tempM, tempM(tempI));
    tempN = tempN - floor(sample_num*(1-paired_ratio)*inc_rate(i));
    eval(['X_view',num2str(i),'(:, inc_index',num2str(i),')= NaN;']);
    eval(['index{end+1}=transpose(setdiff(1:sample_num, inc_index',num2str(i),'));']);
    eval(['data{end+1}=X_view',num2str(i),';']);
end
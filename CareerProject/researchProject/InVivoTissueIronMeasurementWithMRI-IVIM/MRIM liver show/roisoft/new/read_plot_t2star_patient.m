function [t2_h, t2_ll, t2_lr, t2_p, plt_h, plt_ll, plt_lr, plt_p] = read_plot_t2star_patient(hn)

xlsname = ['report_cmrtool_' hn];
num1 = xlsread(xlsname,1);
num2 = xlsread(xlsname,2);
num3 = xlsread(xlsname,3);
num4 = xlsread(xlsname,4);

t2_h = num1(size(num1,1),2);
t2_ll = num2(size(num2,1),2);
t2_lr = num3(size(num3,1),2);
t2_p = num4(size(num4,1),2);

plt_h = num1(1:size(num1,1)-1,:);
plt_ll = num2(1:size(num2,1)-1,:);
plt_lr = num3(1:size(num3,1)-1,:);
plt_p = num4(1:size(num4,1)-1,:);
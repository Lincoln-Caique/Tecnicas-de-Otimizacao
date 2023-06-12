
x1 = [-5 5;-5 5];

##Solução função 1
[xopt1,fopt1,xk1,fk1] = DE1(x1,[15 0.5 1 0.9 100 -1]);

f1min = fopt1;
f2max = (xopt1(1)+2)^2 + (xopt1(2)-3)^2 + ((xopt1(1)^2 - ((xopt1(2)+2)^2))^2)/2;

##Solução função 2
[xopt2,fopt2,xk2,fk2] = DE2(x1,[15 0.5 1 0.9 100 -1]);

f2min = fopt2;
f1max = 20 - (10/(1+(xopt2(1)-3)^2 +(xopt2(2)-2)^2));

x1 = [-5:0.1:5];
x2 = [-5:0.1:5];
for i=1:length(x1)
    for j=1:length(x2)
         x = [x1(i);x2(j)]
        f1(j,i) = 20 - (10/(1+(x(1)-3)^2 +(x(2)-2)^2));
        f2(j,i) = (x(1)+2)^2 + (x(2)-3)^2 + ((x(1)^2 - ((x(2)+2)^2))^2)/2;
    end
end

figure, contour(x1,x2,f1,20); grid
hold, contour(x1,x2,f2,20,'linestyle','--')
plot(xopt1(1),xopt1(2),'*r')
plot(xopt2(1),xopt2(2),'*r')
xlabel('x1')
ylabel('x2')

figure(10), plot(f1min,f2max,'*r'); hold on , grid on
plot(f1max,f2min,'*r')
xlabel('f1')
ylabel('f2')
xlim([0,25])
ylim([0,60])


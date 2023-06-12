
x1 = [-5 5;-5 5];

%Minimiza f1 
[x,f1min] = DE_lambda(x1,[15 0.5 1 0.9 100 -1],[1 0]);
xp(:,1) = x;
f2max = (x(1)+2)^2 + (x(2)-3)^2 + ((x(1)^2 - ((x(2)+2)^2))^2)/2;
fp(:,1) = [f1min;f2max];

%Minimiza f2
[x,f2min] = DE_lambda(x1,[15 0.5 1 0.9 100 -1],[0 1]);
xp(:,2) = x;
f1max = 20 - (10/(1+(x(1)-3)^2 +(x(2)-2)^2));
fp(:,2) = [f1max; f2min];

%Gera a fronteira de pareto
npf = 9; % número de soluões de pareto
k=2;
lbd=linspace(0,1,npf);
lbd(1) = [];
lbd(end)=[];

for a = 0.1:0.1:0.9
    k=k+1;
    lbd1 = [a/(f1max-f1min) (1-a)/(f2max-f2min)];
    [x,fk] = DE_lambda(x1,[15 0.5 1 0.9 100 -1],lbd1);
    xp(:,k)=x;
    fp(1,k) = 20 - (10/(1+(x(1)-3)^2 +(x(2)-2)^2));
    fp(2,k) = (x(1)+2)^2 + (x(2)-3)^2 + ((x(1)^2 - ((x(2)+2)^2))^2)/2;
end

x1 = [-5:0.1:5];
x2 = [-5:0.1:5];
for i=1:length(x1)
    for j=1:length(x2)
        x = [x1(i);x2(j)]
        f1(j,i) = 20 - (10/(1+(x(1)-3)^2 +(x(2)-2)^2));
        f2(j,i) = (x(1)+2)^2 + (x(2)-3)^2 + ((x(1)^2 - ((x(2)+2)^2))^2)/2;
    end
end


figure, meshc(x1,x2,f1);
figure, meshc(x1,x2,f2);
#Curvas 3D sem necessidade


figure, contour(x1,x2,f1,20); grid
hold, contour(x1,x2,f2,20,'linestyle','--')
plot(xp(1,3:end),xp(2,3:end),'ok')
plot(xp(1,1:2),xp(2,1:2),'*r')
xlabel('x1')
ylabel('x2')

figure(10), plot(fp(1,1:2),fp(2,1:2),'*r'), hold on, grid on 
plot(fp(1,3:end),fp(2,3:end),'ok')
xlabel('f1')
ylabel('f2')
xlim([0,25])
ylim([0,60])


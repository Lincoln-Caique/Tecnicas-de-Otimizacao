x1 = [-5 5;-5 5];
%Minimiza f1
eps=inf;
[x,f1min] = DE_epsilon(x1,[15 0.5 1 0.9 100 -1],eps,1);
xp(:,1) = x;
f2max = (x(1)+2)^2 + (x(2)-3)^2 + ((x(1)^2 - ((x(2)+2)^2))^2)/2;
fp(:,1) = [f1min;f2max];

%Minimiza f2
[x,f2min] = DE_epsilon(x1,[15 0.5 1 0.9 100 -1],eps,2);
xp(:,2) = x;
f1max = 20 - (10/(1+(x(1)-3)^2 +(x(2)-2)^2));
fp(:,2) = [f1max; f2min];

%Gera a fronteira de pareto
npf = 9; # número de soluções de pareto
k=2;
eps=linspace(f2min,f2max,npf+2);
eps(1) = [];
eps(end)=[];

for i=1:length(eps)
    k=k+1;
    [x,fk] = DE_epsilon(x1,[15 0.5 1 0.9 100 -1],eps(i),1);
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

#Curvas 3D sem necessidade
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
plot(fp(1,3:npf+2),fp(2,3:npf+2),'o')
plot(fp(1,3:end),fp(2,3:end),'ok')
xlabel('f1')
ylabel('f2')
xlim([0,25])
ylim([0,60])

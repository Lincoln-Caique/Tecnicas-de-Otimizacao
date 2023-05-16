
 #Desconmentar função a partir da alternativa desejada no arquivo quasi_newton
rng(001798);
x0 = [4;4]+rand(2,1);

[xopt,fopt,xk,fk] = elipsoidal(x0,[1e-4 4 1e-4 1000 0]);

x1 = [-10:0.1:10];
x2 = [-10:0.1:10];

for i=1:length(x1)
  for j=1:length(x2)
    x=[x1(i);x2(j)];
    f(j,i) = 0.5*(x(1)^2) + x(2);%Funcao objetivo
    g1(j,i) = -9 + (x(1)-4)^4 + (x(2)-4)^2  ;%Restricao
  end
end

xo = [2.5781; 1.7837];

figure, meshc(x1,x2,f); hold on
meshc(x1,x2,g1)
figure, contour(x1,x2,f,20); grid; hold on
plot(xk(1,:),xk(2,:),'-ok')
plot(xo(1),xo(2),'*r')
contour(x1,x2,g1,[-1e12 0 1e12])
xlabel('x1')
ylabel('x2')


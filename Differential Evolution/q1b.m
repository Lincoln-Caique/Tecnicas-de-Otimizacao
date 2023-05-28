
 #Descomentar função a partir da alternativa desejada no arquivo quasi_newton
x1 = [-5 5;-5 5];

[xopt,fopt,xk,fk] = DE(x1,[10 0.5 1 0.9 100 0.0001]);


x1 = [-5:0.1:5];
x2 = [-5:0.1:5];

for i=1:length(x1)
  for j=1:length(x2)
    x=[x1(i);x2(j)];
    f(j,i) = abs(x(2) - x(1)) + 2*abs(x(1) + 2);
    g(j,i) = 0 ;
  end
end

xo = [-2;-2];

figure, meshc(x1,x2,f)
figure, contour(x1,x2,f,20); grid; hold on
plot(xk(1,:),xk(2,:),'-ok')
plot(xo(1),xo(2),'*r')
xlabel('x1')
ylabel('x2')


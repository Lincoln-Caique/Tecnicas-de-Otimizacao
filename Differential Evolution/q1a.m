
 #Descomentar função a partir da alternativa desejada no arquivo quasi_newton
x1 = [-5 5;-5 5];

[xopt,fopt,xk,fk] = DE(x1,[15 0.5 1 0.9 100 0.0001]);


x1 = [-10:0.1:10];
x2 = [-10:0.1:10];

for i=1:length(x1)
  for j=1:length(x2)
    x=[x1(i);x2(j)];
    f(j,i) = sqrt(10*(x(1)+1)^2 + 5*(x(2)+2)^2)+50*(exp(-(x(1)^2+(x(2)-1)^2)/10))^2;
  end
end

xo = [-1.1543;-3.095];

figure, meshc(x1,x2,f)

figure, contour(x1,x2,f,20); grid; hold on
plot(xk(1,:),xk(2,:),'-ok')
plot(xo(1),xo(2),'*r')
xlabel('x1')
ylabel('x2')


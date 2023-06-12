load("q1a.mat");
load("soma_ponderada.mat");
load("epsilon.mat");

x1 = [-5:0.1:5];
x2 = [-5:0.1:5];
for i=1:length(x1)
    for j=1:length(x2)
        x = [x1(i);x2(j)]
        f1(j,i) = 20 - (10/(1+(x(1)-3)^2 +(x(2)-2)^2));
        f2(j,i) = (x(1)+2)^2 + (x(2)-3)^2 + ((x(1)^2 - ((x(2)+2)^2))^2)/2;
    end
end

figure(10), plot(fp_soma_ponderada(1,1:2),fp_soma_ponderada(2,1:2),'*r'), hold on, grid on 
plot(fp_soma_ponderada(1,3:end),fp_soma_ponderada(2,3:end),'s','color','#8d9c09'), hold on
plot(fp_epsilon(1,3:end),fp_epsilon(2,3:end),'h','color','#1c31a5')
xlabel('f1')
ylabel('f2')
xlim([0,25])
ylim([0,60])

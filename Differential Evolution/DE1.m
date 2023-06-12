 function [xopt, fopt, x, f] = DE(x1,opcoes)

     rng(001798);#seed na inicialização aleatória

    opcoes_dflt = [20 0.5 1 0.9 100 0.1];

    if exist('opcoes','var')
        opcoes = [opcoes, opcoes_dflt(length(opcoes)+1:end)];
    else
        opcoes = opcoes_dflt;
    end

    N = opcoes(1);
    Fmin = opcoes(2);
    Fmax = opcoes(4);
    C = opcoes(4);
    nitmax = opcoes(5);
    prec = opcoes(6);

    n = size(x1,1);

    for i=1:N
        X(:,i) = x1(:,1)+(x1(:,2)-x1(:,1)).*rand(n,1);
        Fx(i) = fncobj(X(:,i));
    end
    Xi = X;

##    for i=1:N
##        Fx(i) = fncobj(X(:,i))
##    end
    k=1
    [f(k), im] = min(Fx);
    x(:,k) = X(:,im);

    disp(sprintf('%5s %11s %11s %11s %11s %11s','It.', 'x1','x2','f'))
  disp(sprintf('%5d %11.5g %11.5g %11.5g %11.5g %11.5g',k-1,x(1,k),x(2,k),f(k)))

    while k <= nitmax
        if prec > 0
            Fxm = max(Fx);
            if (Fxm-f(k)) < prec
                break
            end
        end

        ##Mutação
        for i=1:N
            r=randperm(N,4);
            j=find(r==i);
            r(j)=r(4);
            F = Fmin+(Fmax-Fmin)*rand;
            V(:,i)=X(:,r(1))+F*(X(:,r(2))-X(:,r(3)));

        end

        ##Recombinação
        for i=1:N
            di = randi(n);
            for j = 1:n
                if (j == di) || (rand <= C)
                    U(j,i) = V(j,i);
                else
                    U(j,i) = X(j,i);
                end
            end
        end

        ##Seleção
        for i=1:N
            Fu = fncobj(U(:,i));
            if Fu < Fx(i)
                X(:,i) = U(:,i);
                Fx(i)=Fu;
            end
        end

        k=k+1;
        [f(k),im] = min(Fx);
        x(:,k) = X(:,im);

        disp(sprintf('%5d %11.5g %11.5g %11.5g %11.5g %11.5g',k-1,x(1,k),x(2,k),f(k)))
    end

    xopt = x(:,k);
    fopt = f(k);
    figure
    plot(Xi(1,:),Xi(2,:),'o',X(1,:),X(2,:),'x')
    return

    function f = fncobj(x)
           %a)
      f = sqrt(10*(x(1)+1)^2 + 5*(x(2)+2)^2)+50*(exp(-(x(1)^2+(x(2)-1)^2)/10))^2;

      %b)
##      f = abs(x(2) - x(1)) + 2*abs(x(1) + 2);

      %c)
##      f =  -20*exp(-0.2*(sqrt(0.5*((x(1)+2)^2+(x(2)+2)^2)))) - exp(0.5*(cos(2*pi*x(1)) + cos(2*pi*x(2)))) + exp(1) + 20;

      %2
##             f = 0.5*(x(1)^2) + x(2);
##
##             g=  -9  + (x(1)-4)^4 + (x(2)-4)^2;
##
##            if g> 0
##                f = 10e20+g;
##            end

        return
    end

end

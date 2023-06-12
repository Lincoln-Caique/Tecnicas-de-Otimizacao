 function [xopt, fopt, x, f] = DE_epsilon(x1,opcoes,eps,op)

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
        Fx(i) = fncobj(X(:,i),eps,op);
    end
    Xi = X;

##    for i=1:N
##        Fx(i) = fncobj(X(:,i),eps,op)
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
            Fu = fncobj(U(:,i),eps,op);
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
   
    return

    
    function f = fncobj(x,eps,op)
        #op = 1 -> minimiza f1 restringindo f2; op = 2 o contrário
        f1 = 20 - (10/(1+(x(1)-3)^2 +(x(2)-2)^2));
        f2 = (x(1)+2)^2 + (x(2)-3)^2 + ((x(1)^2 - ((x(2)+2)^2))^2)/2;
        if op == 1
            g = f2-eps;
            if g <= 0
                f=f1;
            else
                f=1e12+g;
            end
        else
            g = f1-eps;
            if g <= 0
                f=f2;
            else
                f=1e12+g;
            end
        end
        return
    end

end

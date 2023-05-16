function [xopt, fopt, x, f] = elipsoidal(x0, opcoes)
    x=x0;

    opcoes_dflt = [1e-5 3 1e-5 500 0];

    if exist('opcoes','var')
        opcoes = [opcoes, opcoes_dflt(length(opcoes)+1:end)];
    else
        opcoes = opcoes_dflt;
    end

    dlt = opcoes(1);
    rm = opcoes(2);
    pp = opcoes(3);
    nitmax = opcoes(4);
    graf = opcoes(5);

    n = length(x);

    b1 = 1/(n+1);
    b2 = n^2/(n^2-1);
    b3 = 2/(n+1);

    E = eye(n);

    k = 1;
    f(k) = fncobj(x(:,k));
    disp(sprintf('%5s %11s %11s %11s %11s %11s','It.', 'x1','x2','f','g1','g2'))

    fmin = f(k);
    fmax = f(k);
    xopt = [];
    fopt = inf;
    Qk = rm^2*eye(n);

    if graf
        figure
        desenhaelipse(-3,3,-3,3,x(:,k),Qk);
        desenha = 0;
        hold
    end

    while k <= nitmax
        r = fncrst(x(:,k));
        if r <= 0
            if f(k) < fopt
                xopt = x(:,k);
                fopt = f(k);
            end
        end

        if k > 4
            f5max = max(f(k-4:k));
            f5min = min(f(k-4:k));
            dltf = f5max-f5min;
            if dltf < pp*(fmax-fmin)
                break
            end
        end

        if r > 0
            for i = 1:n
                g(i,k) = (fncrst(x(:,k)+dlt*E(:,i))-f(k))/dlt;
            end
        else
            for i = 1:n
                g(i,k) = (fncobj(x(:,k)+dlt*E(:,i))-f(k))/dlt;
            end
        end
        disp(sprintf('%5d %11.5g %11.5g %11.5g %11.5g %11.5g',k-1,x(1,k),x(2,k),g(1,k),g(2,k)))

        gQg = g(:,k)'*Qk*g(:,k);
        if gQg <=0
            disp('Finalizou porque a matriz Q perdeu as propriedades requeridas!')
            break
        end

        x(:,k+1) = x(:,k)-(b1*Qk*g(:,k)/sqrt(gQg));
        Qk = b2*(Qk-b3*(Qk*g(:,k))*(Qk*g(:,k))'/(gQg));
        k = k+1;
        f(k) = fncobj(x(:,k));

        if fmin > f(k), fmin = f(k); end
        if fmax < f(k), fmax = f(k); end
        if graf
            desenha=desenha+1;
            if desenha >= graf
                desenhaelipse(-3,3,-3,3,x(:,k),Qk);
                desenha = 0;
            end
        end
    end

    if graf
        hold
    end

    disp(sprintf('%5d %11.5g %11.5g %11.5g',k-1,x(1,k),x(2,k),f(k)))

    return

    function f = fncobj(x)
          %a)
      f = sqrt(10*(x(1)+1)^2 + 5*(x(2)+2)^2)+50*(exp(-(x(1)^2+(x(2)-1)^2)/10))^2;

      %b)
##      f = abs(x(2) - x(1)) + 2*abs(x(1) + 2);

      %c)
##      f =  -20*exp(-0.2*(sqrt(0.5*((x(1)+2)^2+(x(2)+2)^2)))) - exp(0.5*(cos(2*pi*x(1)) + cos(2*pi*x(2)))) + exp(1) + 20;

      %2
##            f = 0.5*x(1)^2 + x(2)  ;


        return
    end

    function r = fncrst(x)
        %1
        r = -1; #Problema irrestrito

        %2
##        r = -9  + (x(1)-4)^4 + (x(2)-4)^2;
        return
    end






end

function [x,f] = quasi_newton(x0,alfa,opcoes)

    x = x0;

    opcoes_dflt = [1e-5 1e-5 1 1e-5 500];

    if exist('opcoes','var')
        opcoes = [opcoes, opcoes_dflt(length(opcoes)+1:end)];
    else
        opcoes = opcoes_dflt;
    end

   dlt = opcoes(1);
   epsl = opcoes(2);
   rm = opcoes(3);
   pp = opcoes(4);
   nitmax = opcoes(5);

   n = max(size(x));

   E = eye(n);
   Hk = E;

   k = 1;
   f(k) =fncobj(x(:,k));

   fmin = f(k);
   fmax = f(k);
  %Calcula o gradiente
   for i = 1:n
      g(i,k) = (fncobj(x(:,k)+dlt*E(:,i))-f(k))/dlt;
   end
    disp(sprintf('%5s %11s %11s %11s %11s %11s','It.', 'x1','x2','f','g1','g2'))
    disp(sprintf('%5s %11.5g %11.5g %11.5g %11.5g %11.5g',k-1, x(1,k),x(2,k),f(k),g(1,k),g(2,k)))

    while 1
        if k > 4
            f5max = max(f(k-4:k));
            f5min = min(f(k-4:k));
            dltf = f5max-f5min;
            if dltf < pp*(fmax-fmin) | (k > nitmax)
                break
            end

        end
        dk=-Hk*g(:,k);

        li = 0;
        ls = rm;
        ai = ls - 0.618*(ls-li);
        as = li + 0.618*(ls-li);
        fi = fncobj(x(:,k)+ai*dk);
        fs = fncobj(x(:,k)+as*dk);
        while (ls-li) > epsl
            if fi < fs
                ls = as;
                as = ai;
                ai = ls - 0.618*(ls-li);
                fs = fi;
                fi = fncobj(x(:,k)+ai*dk);
            else
                li= ai;
                ai = as;
                fi = fs;
                as = li+ 0.618*(ls-li);
                fs = fncobj(x(:,k)+as*dk);
            end
        end
        ai = (li+ls)/2;
        %Determina novo x
        x(:,k+1) = x(:,k)+ai*dk;
        f(k+1) = fncobj(x(:,k+1));
        %Atualiza Hessiana
        %Calculo do gradiente
        for i = 1:n
            g(i,k+1) = (fncobj(x(:,k+1)+dlt*E(:,i))-f(k+1))/dlt;
        end
        vk = x(:,k)-x(:,k+1);
        rk = g(:,k)-g(:,k+1);
        CkDFB = vk*vk'/(vk'*rk) - Hk*rk*rk'*Hk/(rk'*Hk*rk);
        CkBFGS= ((1+((rk'*Hk*rk)/(rk'*vk))) * ((vk*vk')/(vk'*rk))) - (vk*rk'*Hk+Hk*rk*vk')/(rk'*vk);
        Ck = (1-alfa)*CkDFB + alfa*CkBFGS;
        Hk = Hk+Ck;

##        if min(eig(Hk)) <= 0
##          disp("Reiniciando H!");
##          Hk = eye(n);
##          break
##        endif

        k = k + 1;
        %Determina os máximos e mínimos da funcaso objetivo
        if fmin > f(k), fmin = f(k); end
        if fmax < f(k), fmax = f(k); end
        disp(sprintf('%5d %11.5g %11.5g %11.5g %11.5g %11.5g',k-1,x(1,k),x(2,k),f(k),g(1,k),g(2,k)))
    end

    #Desconmentar função a partir da alternativa desejada
    function f = fncobj(x)
      %1
      %a)
      f = sqrt(10*(x(1)+1)^2 + 5*(x(2)+2)^2)+50*(exp(-(x(1)^2+(x(2)-1)^2)/10))^2;

      %b)
##      f = abs(x(2) - x(1)) + 2*abs(x(1) + 2);

      %c)
##      f =  -20*exp(-0.2*(sqrt(0.5*((x(1)+2)^2+(x(2)+2)^2)))) - exp(0.5*cos(2*pi*x(1)) + cos(2*pi*x(2))) + exp(1) + 20;


      %2
     g1=  -9  + (x(1)-4)^4 + (x(2)-4)^2;

##     %barreira
##     bar = -0.00202/g1;
##      f = 0.5*x(1)^2 + x(2) + bar ;

      %penalidade
##        if g1> 0
##            g1 = (g1+g1^2);
##        end
##        f = 0.5*(x(1)^2) + x(2)+ 0.225*g1 ;
    end

    end

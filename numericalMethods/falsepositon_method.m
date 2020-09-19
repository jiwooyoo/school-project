ea=100; es=1e-5; maxit=100;
it=0; tzero=0.73908513321516064166;
ealist=zeros(1,maxit);
etlist=zeros(1,maxit);
f=@(x) x-cos(x);
xl=-3; xu=3;
while 1
    xr=xu-(f(xu)*(xl-xu))/(f(xl)-f(xu));
    it=it+1;
    if it==1
        ea=nan;
    else
        ea=abs((xr-xrold)/xr)*100;
    end
    et=abs((tzero-xr)/tzero)*100;
    ealist(it)=ea;
    etlist(it)=et;
    
    test=f(xl)*f(xr);
    if test==0
        ea=0;
    elseif test>0
        xl=xr;
    else
        xu=xr;
    end
    xrold=xr;
    if ea<=es || it>maxit
        break;
    end
end
semilogy(ealist,'r-'); hold on;
semilogy(etlist,'b-'); hold on; grid on;
xlabel('Iterations');
ylabel('Percent relative error');
legend('Approximate','True'); 
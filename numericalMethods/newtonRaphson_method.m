ea=100; es=1e-5; maxit=100;
it=0; tzero=0.73908513321516064166;
ealist=zeros(1,maxit);
etlist=zeros(1,maxit);
f=@(x) x-cos(x);
fp=@(x) 1+sin(x);
oldx=0;
while 1
    newx=oldx-f(oldx)/fp(oldx);
    it=it+1;
    ea=abs((newx-oldx)/newx)*100;
    ealist(it)=ea;
    et=abs((tzero-newx)/newx)*100;
    etlist(it)=et;
    oldx=newx;
    if ea<=es || it>maxit
        break;
    end
end
semilogy(ealist,'r-'); hold on;
semilogy(etlist,'b-'); hold on; grid on;
xlabel('Iterations');
ylabel('Percent relative error');
legend('Approximate','True'); 
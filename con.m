[x,fs]=audioread("Sound_data/speech16k.wav");
x_length=length(x);
x = x.';
[g,fs]=audioread("Sound_data/short_delay_200.wav");
g_length=length(g);
g = g.';
gzero = [g zeros(1,x_length-1)];
xzero = [x zeros(1,g_length-1)];
y_length=g_length+x_length-1;
y=zeros(1,y_length);
for n=1:y_length-1
    for k=1:n
        temp = n-k;
        if temp <= 0
            temp = 1;
        end
        %disp(n);
        %disp(k)
        %disp(temp);
        y(n)=y(n)+gzero(k)*xzero(temp);
    end
end

yc=conv(x,g);
fx=fft(yc(6001:14000));
plot(20.*log10(abs(fx(1:2000))));
sound(yc, 16000);
%plot(y(5001:7000))
%hold on
%plot(yc(5001:7000))
%hold off

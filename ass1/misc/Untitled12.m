L=[]
for i = 1:length(lines)
    T = lines(i).theta;
    if -10<T && T<10 || 170<T && T<190 || 80<T && T<100 || -100<T && T<-80
        L = [L lines(i)];
    end
end

lines = L;


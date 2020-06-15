% Find the highest horizontal line
H = []
for i = 1:length(lines)
    T = lines(i).theta;
    if -90<T && T<-80 || 80<T && T<89 % horizontal
        H = [H lines(i)]
    end
end

highest = H(1);
for i = 1:length(H)
    if H(i).point1(2) < highest.point1(2)
        highest = H(i);
    end
end
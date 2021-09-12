load labdat
bb = 1/5*ones(1,5);
y1 = firfilt(bb,x1);
length(x1)
length(y1)

figure(24)
plot(x1)
title('Lab3: Part 2.4a')

%nn = 1:length(x1); %part 2.4b
nn = 1:round(length(x1)/30):length(x1); %part 2.4c
length(nn)
figure(1)
subplot(2,1,1);
stem(nn,x1(nn))
title('Lab3: Part 2.4b1')
subplot(2,1,2);
stem(nn,y1(nn),'filled') %--Make black dots
title('Lab3: Part 2.4b2')
xlabel('Time Index (n)')

%part d
bb = 1/2*ones(1,2);
y1 = firfilt(bb,x1);
length(x1)
length(y1)

figure(26)
plot(y1)
title('Lab3: Part 2.4d')
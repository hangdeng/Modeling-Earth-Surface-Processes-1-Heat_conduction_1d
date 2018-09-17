% this code generates a linear geotherm
% written by rsa 1/13/2016

clear all
figure(1)
clf

%% inialize

Ts = -55; % degrees C
k1 = 2.2; % W/(m-K)
k2 = 3.5;

Q = 0.054; % W/m2

dz = 1;
zmax1 = 2000;
zmax2 = 4000;
z1 = 0:dz:2000;
z2 = zmax1:dz:zmax2;
z = 0:dz:zmax2;

T1 = Ts + (Q./k1) .*z1;
T2 = T1(zmax1) + (Q./k2) .*(z2-2000);
Tzero = zeros(size(z));

figure(1)
plot(T1,z1,'k','linewidth',2)
hold on
plot(T2,z2,'k','linewidth',2)
hold on 
plot(Tzero,z,'g--')


    xlabel('Temperature','fontname','arial','fontsize',21)
    ylabel('Depth (m)','fontname','arial','fontsize',21)
    set(gca,'fontsize',18,'fontname','arial')
    set(gca,'YDIR','reverse')


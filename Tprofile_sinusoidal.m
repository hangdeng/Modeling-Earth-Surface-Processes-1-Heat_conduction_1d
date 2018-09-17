% sinusoidal forcing of a 1D thermal profile
% written by rsa for modeling class jan 2016

clear all
figure(1)
clf

%% initialize

Ts = -10;
DT = 15;
DT_daily=10;
kappa = 1e-6; %m2/s

dz = 0.05;
zmax = 15;
z=0:dz:zmax;

%dt = 10*(3600*24); % secs
dt = (3600*6); % secs
P = 365*(3600*24);
P_day = 24*3600;
tmax = P;
%nplots = 100;
tplot = dt;

t = 0:dt:tmax;

imax = length(t);

Tzero = zeros(size(z));
zstar = sqrt(kappa*P/pi);
zstar_daily = sqrt(kappa*P_day/pi);

% evaluate envelopes enclosing all temperatures

Tenv_low = Ts-DT*exp(-z/zstar) - DT_daily*exp(-z/zstar_daily);
Tenv_high = Ts+DT*exp(-z/zstar) + DT_daily*exp(-z/zstar_daily);

nframe = 0;
%% run

for i = 1:imax
    
    Tannual = Ts + DT*exp(-z./zstar).*sin((2*pi*t(i)/P)-(z./zstar));
    
    Tdaily = Tannual + (DT_daily*exp(-z./zstar_daily).*sin((2*pi*t(i)/P_day)...
        -(z./zstar_daily)));
        
    if(rem(t(i),tplot)==0)
        nframe = nframe+1;
    figure(1)
    plot(Tdaily,z,'r','linewidth',2)
    xlabel('Temperature (°C)','fontname','arial','fontsize',21)
    ylabel('Depth (m)','fontname','arial','fontsize',21)
    set(gca,'fontsize',18,'fontname','arial')
    set(gca,'YDIR','reverse')
    axis([Ts-DT-DT_daily-1 Ts+DT+DT_daily+1 0 zmax])
    hold on
    plot(Tenv_low,z,'g','linewidth',2)
    plot(Tenv_high,z,'g','linewidth',2)
    plot(Tzero,z,'k--','linewidth',2)
    
    M(:,nframe) = getframe(gcf);
    pause(0.05)
    hold off
    
    end
    
end

%%  finalize

% final plotting
%     figure(1)
%     plot(Tenv_low,z,'g--','linewidth',2)
%     plot(Tenv_high,z,'g--','linewidth',2)
%     xlabel('Temperature (°C)','fontname','arial','fontsize',21)
%     ylabel('Depth (m)','fontname','arial','fontsize',21)
%     set(gca,'fontsize',18,'fontname','arial')
%     set(gca,'YDIR','reverse')
%     axis([Ts-DT-DT_daily-1 Ts+DT+DT_daily+1 0 zmax])

%movie2avi(M,'Tprofile_annual&daily','fps',24) %
function [T,nb_ni,vb] = temp_from_distbn_fn(distbn_fn,v_axis,mass,bimax,minBeamVel,plots)
% calculates the temperature from a given velocity distribution function.
% If more than one distribution function is given, then they are averaged
% before fitting.
% The fit uses Leven-Marquardt non-linear fitting and can include one or
% two maxwellian distributions (no-beam or beam)
%
% INPUTS
% distbn_fn : the distribution function [pdf, normalisation is irrelevant]
%           : the first dimension should be the velocity
% v_axis    : the velocity axis [ms^-1]
% mass      : particle mass [kg]
% bimax     : whether to use one or two maxwellian distributions [boolean]
% minBeamVel: only search for beam above this velocity [m/s]. If not 
%             specified, it will be set to -Inf
% plots     : whether the fit result will be plotted
%
% OUTPUT
% T(1)      : temperature of bulk                       [eV]
% T(2)      : temperature of beam (if required) n1>n2   [eV]
%               T is a vector with 2 elements
% nb_ni     : relative density of beam and bulk [no units]
% vb        : beam velocity [m/s]

%Author: Chris Rapson

natconst;

if nargin<2
    help temp_from_distbn_fn
    error('craq_error','Not enough input arguments');
elseif nargin<3 || isempty(mass)
    mass=m_ar;
    bimax=0;
    minBeamVel=-Inf;
    plots=0;
elseif nargin<4 || isempty(bimax)
    bimax=0;
    minBeamVel=-Inf;
    plots=0;
elseif nargin<5 || isempty(minBeamVel)
    minBeamVel=-Inf;
    plots=0;
elseif nargin<6 || isempty(plots)
    plots=0;
end

if isempty(mass)
    mass=m_ar;
end

if mass==0 || mass==1
    warning('argument order has changed')
    minBeamVel=bimax;
    bimax=mass;
    mass=m_ar;
end

%average over non-velocity dimensions
while size(distbn_fn,2)>1
    distbn_fn=mean(distbn_fn,ndims(distbn_fn));
end

%convert to column vector
distbn_fn=distbn_fn(:);
v_axis=v_axis(:);

distbn_fn=distbn_fn(1:length(v_axis));

if bimax
% % %     ftype = fittype('gauss2');
% % %     opts = fitoptions('gauss2');
% % %     opts.Lower = [0 -Inf 0 0 -Inf 0];
% % %     gfit = fit(v_axis,distbn_fn,ftype,opts);
% % %     %gfit(x) = a1*exp(-((x-b1)/c1)^2) + a2*exp(-((x-b2)/c2)^2)
% % %     T(1)=(gfit.c1)^2*mass/2/k_b;%(max([gfit.c1,gfit.c2]))^2*mass/2/k_b;
% % %     T(2)=(gfit.c2)^2*mass/2/k_b;%(min([gfit.c1,gfit.c2]))^2*mass/2/k_b;
% % % 
% % %     nb_ni=gfit.a1/gfit.a2;
% % %     if nb_ni>1
% % %         nb_ni=1/nb_ni;
% % %     end
% % %     vb=abs(gfit.b1-gfit.b2);%in units of the input v_axis

    ftype=fittype('gauss1');
    opts=fitoptions('gauss1');
    opts.Lower=[0 min(v_axis) 0];
    opts.Upper=[Inf max(v_axis) sqrt((100*e/k_b)/mass*2*k_b)];%maximum temperature is 100eV. For VINETA and KNM_PIC this is enough
    opts.TolFun=max(distbn_fn)/1e6;
    gfit=fit(v_axis,distbn_fn,ftype,opts);
 
%     figure
%     subplot(131)
%     plot(v_axis,distbn_fn)
%     hold all
%     plot(v_axis,gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2))
    
    %use when looking for a beam with +ve velocity from simulation
    opts.Lower=[0 minBeamVel 0];%minBeamVel+gfit.b1?
    db2=distbn_fn-gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2);
    gfit=fit(v_axis,db2,ftype,opts);
    T(2)=(gfit.c1)^2*mass/2/k_b;
    n(2)=gfit.a1;
    v(2)=gfit.b1;
    c2=gfit.c1;
    
%     subplot(132)
%     plot(v_axis,distbn_fn)
%     hold all
%     plot(v_axis,gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2))
%     plot(v_axis,db2)

    opts.Lower=[0 -Inf 0];
    db1=distbn_fn-gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2);
    gfit=fit(v_axis,db1,ftype,opts);
    T(1)=(gfit.c1)^2*mass/2/k_b;
    n(1)=gfit.a1;
    v(1)=gfit.b1;
    c1=gfit.c1;

%     subplot(133)
%     plot(v_axis,distbn_fn)
%     hold all
%     plot(v_axis,gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2))
%     plot(v_axis,db1)
    
    nb_ni=n(2)/n(1);
    vb=abs(v(2)-v(1));
    
    clear gfit
    gfit.a2=n(2);
    gfit.b2=v(2);
    gfit.c2=c2;
    gfit.a1=n(1);
    gfit.b1=v(1);
    gfit.c1=c1;
    
    if plots
        figure
        plot(v_axis,distbn_fn)
        hold all
        plot(v_axis,gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2))
        plot(v_axis,gfit.a2*exp(-((v_axis-gfit.b2)/gfit.c2).^2))
        plot(v_axis,gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2)+gfit.a2*exp(-((v_axis-gfit.b2)/gfit.c2).^2))
    %     plot(v_axis,gfit.a1*sqrt(mass/2/pi/k_b/T(1))*exp(-(v_axis-gfit.b1).^2*mass/2/k_b/T(1)))
    %     plot(v_axis,gfit.a2*sqrt(mass/2/pi/k_b/T(2))*exp(-(v_axis-gfit.b2).^2*mass/2/k_b/T(2)))
        title('Gaussian Fit to Distribution Function')
    end
else
    %     cfun_e=fit(v_axis,distbn_fn,'gauss1',...
    %         'Lower',[0,v_axis(1),0],'Upper',[Inf,v_axis(end),Inf],...
    %         'MaxFunEvals',50,...
    %         'MaxIter',20);
    %     cfv=coeffvalues(cfun_e);
    %     T=mass*cfv(3)^2/2/k_b;
    %
    %     plot(v_e,sqrt(m_e/2/pi/k_b/A)*exp(-(v_e-v0).^2*m_e/2/k_b/T_e_fit))

        ftype = fittype('gauss1');
        opts = fitoptions('gauss1');
        opts.Lower = [0 -Inf 0];
        gfit = fit(v_axis,distbn_fn,ftype,opts);
        %gfit(x) = a1*exp(-((x-b1)/c1)^2) + a2*exp(-((x-b2)/c2)^2)
        T=(gfit.c1)^2*mass/2/k_b;

        nb_ni=0;
        vb=0;

        if plots
            figure
            plot(v_axis,distbn_fn)
            hold all
            plot(v_axis,gfit.a1*exp(-((v_axis-gfit.b1)/gfit.c1).^2))
            plot(v_axis,gfit.a1*sqrt(mass/2/pi/k_b/T)*exp(-(v_axis-gfit.b1).^2*mass/2/k_b/T))
        end
        
end

T=T/e*k_b; %convert Kelvin to eV

return

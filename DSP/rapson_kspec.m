function [kaxe,spec_d,spec_t] = rapson_kspec(x, L, nf, autosave, kmax, wname, displ)
% k-power wavelet spectrum
% INPUTS
% x    : space series (dimension [ntime, nprobes])
% L    : length of measurement domain
% nf   : # of coefficients (default is 32)
% autosave:  data are saved if equal to 1
% kmax      maximum wavenumber of the spectrum. 
%           Default is half of the Nyquist wavenumber.
% wname: name of the wavelet used (default is Morlet)
% displ: 1 for display of k-spectra (1 is default)
%
% OUTPUTS
% kaxe    : spatial frequency values for the k axis [rad/m] if L was in metres
% spect_d : spatially resolved spectrum of spatial frequencies
% spect_t : time resolved spectrum of spatial frequencies
% 
%

%Author: Chris Rapson
% based on a program by F. Brochard

if (nargin<7 || isempty(displ)),	    displ = 1;      end
if (nargin<6 || isempty(wname)),        wname='cmor1-1.5';  end
if (nargin<5 || isempty(kmax)),         kmax=-1;        end
if (nargin<4 || isempty(autosave)),     autosave = 0;   end
if (nargin<3 || isempty(nf) || nf < 0),	nf = 64;        end
if (nargin<2 || isempty(L)  || L<0),	dx = 1;         end

x=x';                 %transpose so that fft works on spatial dimension
[n,ntime] = size(x);

nf=2*ceil(nf/2);      %make sure nf is even

dx=L/n;


% ---- scales for the axis ---- 
% kmin = 1/n/dx*2*pi;			% min allowed wavenumber %NOT USED
kNyq = 1/dx/2*2*pi;			% Nyquist wavenumber
if kmax<0 || kmax>kNyq
    kmax = kNyq;        % Maximum wavenumber for accurate analysis
end

%changed linear k axis to logarithmic cjr 20110923
% kaxe = (1:nf)'/nf*kmax;     % wavenumber axis (skip k=0)
kaxe=logspace(log10(1/nf),log10(kmax),nf);
if kaxe(end)>kmax %correct for numerical rounding error 
    kaxe(end)=kmax;
end
sigma=scal2frq(1,wname); % set the correspondence coeff/scale
scale = sigma ./ (kaxe*dx);	% scale axis for wavelets
% i don't understand this bit... scal2freq should take the scales as input?
%freq=scal2freq(scale,wname,dx);

ntot = n*ntime;     % total # of points

disp('** computing wavelet transform **')
% wy=nan(ntime,96-33+1,nf);
wy=nan(ntime,n,nf);
for j=ntime:-1:1
    if mod(ntime-j+1,50)==1
        disp(['data set ',int2str(ntime-j+1),' of ',int2str(ntime)])
    end
    coefs = cwt(detrend(x(:,j)),scale,wname);
%     wxj=coefs';
	wy(j,:,:) = (coefs.*conj(coefs))';%wxj;%(33:96,1:nf); % dimension of wy : ntime * nprobes * ncoefs
    % considering the central interval [33:96] avoids edge effects
end
clear coefs
% ---------- performing spectra calculation ------------
% spec_d_t=wy.*conj(wy);%nan(ntime,n,nf);
% clear wy
spec_d=squeeze(mean(wy,1));
spec_t=squeeze(mean(wy,2));
% for tim=1:ntime
%     wyt(:,:)=wy(tim,:,:);               % coefs at a given time
%     spec_d_t(tim,:)=sum(wyt.*conj(wyt));  % Summed < Y*(k) Y(k)> at a given time
% end

if ntime>1
    spec=mean(spec_t);  % k-spectrum averaged over time
else
    spec=spec_t(1,:);
end% ---- time evolution of the k-spectrum -----
if displ==1
    figure; set(gcf,'color','w');
    
    if ntime > 20
        surf(1:ntime,kaxe,sqrt(spec_t')),shading('interp');
        colormap('hot'),view(2); %colorbar('southoutside');
        axis([1 ntime kaxe(1) kaxe(nf)]);
        xlabel('Time step','fontsize',14),ylabel('Spatial Frequency','fontsize',14);
        title('Time evolution of the mean k-spectrum');
        
        figure; set(gcf,'color','w');
        semilogy(kaxe,spec,'r','linewidth',2);hold off;
        title('mean k spectrum'); 
        xlabel('Spatial Frequency','fontsize',14); ylabel('PSD [a.u]','fontsize',14);
        grid; 
        %axis([0 16 0.4*min(spec) 2*max(spec)]);
        axis tight
        
    else
        semilogy(kaxe,spec,'r','linewidth',2);
        title('mean k spectrum'); 
        xlabel('Spatial Frequency','fontsize',14); ylabel('S(k) (a.u.)','fontsize',14);
        grid; 
%         if r==1
%             axis([0 kmax 0.4*min(spec) 2*max(spec)]);
%         end    
        axis tight
    end
end

% ******** autosave ? *********
if autosave == 1
    wavkspec.avspec = spec;
    wavkspec.spec   = spec_t;
    wavkspec.kaxe   = kaxe;
    wavkspec.time   = [1:ntime];
    save wavkspec.mat wavkspec;
    disp('Data were successfully stored in file wavkspec.mat')
end



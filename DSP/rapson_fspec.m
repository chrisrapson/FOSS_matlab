function [freq,spec_d,spec_t] = rapson_fspec(sig, fs, nf, autosave, fmax, wname, displ,start_index,end_index,fmin)
%   Wavelet frequency spectrum
% computes the changes in temporal frequency components over space and time
%
% INPUTS
%   sig :   time series (dimension [ntime, nprobes])
%   fs  :   sampling frequency
%   nf  :   # of wavelet coefficients  
%   autosave:   data are saved if equal to 1
%   fmax:   maximum freq of the spectrum. [same units as fs, not normalised]
%           Default is half of the Nyquist frequency 
%           i.e. 1/4 the sample rate)
%   wname:  name of the wavelet function used (default = Morlet) 
%   displ:  1 for display of f-spectra graphs (1 is default)
%   start_index : index from which to start to avoid edge effects (default=1)
%   end_index   : index at which to stop to avoid edge effects (default=end)
%   fmin        : minimum frequency of the spectrum. [same units as fs, not normalised]
%
% OUTPUTS
% freq  : frequency scale of the outputs [Hz] (if fs is in seconds)
% spec_d: spatially resolved time (f) spectra from wavelet transformations
% spec_t: temporally resolved time (f) spectra from wavelet transformations
%

%Author: Chris Rapson
% based on a program by F. Brochard

if (nargin<10 || isempty(fmin)),        fmin=-1;       end
if (nargin<9 || isempty(end_index)),     end_index=-1;   end
if (nargin<8 || isempty(start_index)),   start_index=1;  end
if (nargin<7 || isempty(displ)),	    displ = 1;      end
if (nargin<6 || isempty(wname)),        wname='cmor1-1.5';  end
if (nargin<5 || isempty(fmax)),         fmax=-1;        end
if (nargin<4 || isempty(autosave)),     autosave = 0;   end
if (nargin<3 || isempty(nf) || nf < 0),	nf = 256;        end
if (nargin<2 || isempty(fs) || fs<0),	fs = 1;         end

[ntime,nsig] = size(sig);
% nf=2*ceil(nf/2); %check that nf is even %why?? cjr 20111122
if end_index<0
    end_index=ntime;
end

sigma=scal2frq(1,wname); % set the correspondence coeff/scale

dt=1/fs;
if ~exist('fmin','var') || fmin<0
    fmin = 2/ntime/dt;			% min allowed frequency
end
fNyq = 1/dt/2;              % Nyquist frequency
if fmax<0,  fmax = fNyq/2;  end

% freq = (1:nf)'/nf*(fmax-fmin);	% frequency axis (skip f=0)
% freq=freq+fmin;
freq=logspace(log10(fmin),log10(fmax),nf);
if freq(end)>fmax %correct for numerical rounding error 
    freq(end)=fmax;
end
scale = sigma ./ (freq*dt);		% scale axis for wavelets
timscale=dt:dt:ntime*dt;

%fmax = fNyq; 
nsmo = 0;

disp('** computing wavelet transform **')
% ---------- performing spectra calculation ------------
freq1 = freq(2:end);
freq1 = freq1(freq1<=fmax);
nf = length(freq1);
nf2 = fix(nf/2);
neff = round(ntime/nf);				% # of independent ens.
% spec_p=nan(nsig,length(freq)-1);
spec_d_t=nan(nsig,end_index-start_index+1,nf+1);
tic
for j=nsig:-1:1
    if mod(nsig-j+1,50)==1
        toc
        disp(['data set ',int2str(nsig-j+1),' of ',int2str(nsig)])
        tic
    end
	coefs = cwt(detrend(sig(:,j)),scale,wname);   % wavelet coefficients
	%   size(wxj) = ntime * ncoeffs (= neff * nf)
% %     fx(1+(j-1)*ntime:j*ntime,:)=coefs';%wxj;
% % 
% % 
% %     fx(:,1) = [];				% remove DC component
% % 
% %     %--------------------------
% % 
% %     nwind = size(fx,1);				% # of ensembles
% %     if nwind<2,
% %         error('** there are not enough spectra to average **');
% %     end
% % 
% %     fx = fx(:,1:nf);
% % 
% %     if nf2<1, error('** frequency range is too small **');	end
% % 

% %     spec_p(j,:) = sum(fx.*conj(fx))/nwind;		% power spectral density
    spec_d_t(j,:,:)=(coefs(1:nf+1,start_index:end_index).*conj(coefs(1:nf+1,start_index:end_index)))';

% %     clear fx;
end

clear coefs
spec_t=squeeze(mean(spec_d_t,1));
spec_d=squeeze(mean(spec_d_t,2));

%
% 
% if nsig>1
%     spec=mean(spec_p);
% else
%     spec=spec_p(1,:);
% end

if displ==1
    figure; set(gcf,'color','w');

    pcolor(timscale,freq,abs(coefs)),shading('interp')
    colormap('jet')
    title('Wavelet frequency spectrum')
    xlabel('Time [s]','fontsize',14);
    ylabel('F [Hz]','fontsize',14)

    figure; set(gcf,'color','w');
    semilogy(freq, mean(abs(coefs),2),'linewidth',2);
    grid
    title('Time averaged frequency spectrum')
    xlabel('Frequency (Hz)','fontsize',14)
    ylabel('S(f) (a.u.)','fontsize',14)
end
    
% ******** autosave ? *********
if autosave == 1
    wavfspec.spec   = abs(coefs);
    wavfspec.avspec = mean(abs(coefs),2);
    wavfspec.time    = timscale;
    wavfspec.freq    = freq;
    save wavfspec.mat wavfspec;
    disp('Data were successfully stored in file wavspec.mat')
end

return
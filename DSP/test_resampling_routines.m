%answer: use upfirdn! does matrices aswell
%      : DONT use resample. The prefilter it uses has crazy edge effects
%      : decimate for downsampling and rapsonc_resample for upsampling are ok

%Author: Chris Rapson

% TODO: interp1 and upfirdn

x=linspace(1,40,40);
downsample_rate=2;
upsample_rate=2;
y1=decimate(x,downsample_rate); %can only do integer, uses prefilter
y2=resample(x,1,downsample_rate);%any rate, uses prefilter
y6=downsample(x,downsample_rate);%can only do integer, no filtering

y3=resample(x,upsample_rate,1);
y4=interp(x,upsample_rate);
y5=rapsonc_resample(x,upsample_rate);
y7=upsample(x,upsample_rate);

figure_tiled
plot(x)
hold all
plot(y1)
plot(y2)
plot(y6)
plot(y3)
plot(y4)
plot(y5)
plot(y7)
legend('original','decimate','resample down','downsample','resample up','interp','rapsonc resample','upsample')

%%
x=[linspace(1,20,20) linspace(1,20,20)];
downsample_rate=2;
upsample_rate=2;
y1=decimate(x,downsample_rate);
y2=resample(x,1,downsample_rate);
y6=downsample(x,downsample_rate);

y3=resample(x,upsample_rate,1);
y4=interp(x,upsample_rate);
y5=rapsonc_resample(x,upsample_rate);
y7=upsample(x,upsample_rate);

figure_tiled
plot(x)
hold all
plot(y1)
plot(y2)
plot(y6)
plot(y3)
plot(y4)
plot(y5)
plot(y7)
legend('original','decimate','resample down','downsample','resample up','interp','rapsonc resample','upsample')

%%
x=ones(1,40);
x(20)=2;
x(25)=2;
downsample_rate=2;
upsample_rate=2;
y1=decimate(x,downsample_rate);
y2=resample(x,1,downsample_rate);
y6=downsample(x,downsample_rate);

y3=resample(x,upsample_rate,1);
y4=interp(x,upsample_rate);
y5=rapsonc_resample(x,upsample_rate);
y7=upsample(x,upsample_rate);

figure_tiled;
plot(linspace(0,1,length(x)),x)
hold all
plot(linspace(0,1,length(y1)),y1)
plot(linspace(0,1,length(y2)),y2)
plot(linspace(0,1,length(y6)),y6)
plot(linspace(0,1,length(y3)),y3)
plot(linspace(0,1,length(y4)),y4)
plot(linspace(0,1,length(y5)),y5)
plot(linspace(0,1,length(y7)),y7)
legend('original','decimate','resample down','downsample','resample up','interp','rapsonc resample','upsample')
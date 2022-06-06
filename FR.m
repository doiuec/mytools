%Create Audio
sampleRate = 48e3;
device = 'Steinberg UR12';

aDR = audioDeviceReader

aDW = audioDeviceWriter
  
%Test Signal
samplePerFrame = 1024;
sineSource = audioOscillator( ...
    "Frequency",0, ...
    "SignalType", "sine", ...
    "SampleRate", sampleRate, ...
    "SamplesPerFrame", samplePerFrame);

%Spectrum Analyzer
RBW = 50;
Navg = 20;
scope = dsp.SpectrumAnalyzer( ...
    "Method", "Filter bank", ...
    "SampleRate", sampleRate, ...
    "RBWSource", "Property", "RBW", RBW, ...
    'SpectralAverages',Navg, ...
    'FrequencySpan','Start and stop frequencies',...
    'StartFrequency',0, ...
    'StopFrequency',sampleRate/2, ...
    'ReducePlotRate',false, ...
    'PlotAsTwoSidedSpectrum',false, ...
    'FrequencyScale','Log', ...
    'PlotMaxHoldTrace',true, ...
    'ShowLegend',true, ...
    'YLimits',[-110 20],...
    'YLabel','Power', ...
    'Title','Audio Device Frequency Response');

%Loop
tic
while toc < 5
    x = sineSource();
    aDW(x);
    y = aDR();
    scope(y);
end

count  = 1;
readerDrops = 0;
writerDrops = 0;

while true
    if count == Navg
        newFreq = sineSource.Frequency + RBW;
        if newFreq > sampleRate/2
            break
        end
        sineSource.Frequency = newFreq;
        count = 1;
    end
    
    x = sineSource();
    writerUnderruns = aDW(x);
    [y,readerOverruns] = aDR();
    readerDrops = readerDrops + readerOverruns;
    writerDrops = writerDrops + writerUnderruns;
    scope(y);
    count = count + 1;
end

release(aDR)
release(aDW)
release(scope)


%FRM result
data = getSpectrumData(scope);
freqVector = data.FrequencyVector{1};
freqResponse = data.MaxHoldTrace{1};

semilogx(freqVector,freqResponse);
xlabel('Frequency (Hz)');
ylabel('Power (dBm)');
title('Audio Device Frequency Response');
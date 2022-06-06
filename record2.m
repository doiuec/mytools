%Create Object
sampleRate = 192e3;

deviceReader = audioDeviceReader(...
    "SampleRate", sampleRate,...
    'BitDepth','16-bit integer');
deviceWriter = audioDeviceWriter(...
    "SampleRate", sampleRate,...
    'BitDepth','16-bit integer');

%audio process
scope = dsp.SpectrumAnalyzer("SampleRate", deviceReader.SampleRate);
scope.ViewType = 'Spectrogram';
scope.RBWSource = 'Property';
scope.RBW = 100;
scope.TimeSpanSource = 'Property';
scope.TimeSpan = 10;
scope.PlotAsTwoSidedSpectrum = false;


%main func
disp("Begin Input...")
tic
while(toc<60)
    mySignal = deviceReader();
    deviceWriter(mySignal);
    scope(mySignal)
end
disp("End Input...")

release(deviceReader)
release(deviceWriter)
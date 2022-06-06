Array = readmatrix('data2.csv');
data = Array(:,2);

Fs = 500e4;
frameSize = 20e3;
chirp = dsp.Chirp('SampleRate',Fs,...
  'SamplesPerFrame',frameSize,...
  'InitialFrequency',11e3,...
  'TargetFrequency',11e3+55e3);

scope = dsp.SpectrumAnalyzer('SampleRate',Fs);
scope.ViewType = 'Spectrogram';
scope.RBWSource = 'Property';
scope.RBW = 100;
scope.TimeSpanSource = 'Property';
scope.TimeSpan = 2;
scope.PlotAsTwoSidedSpectrum = false;

scope(data);

release(scope)
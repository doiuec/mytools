%Create Object
deviceReader = audioDeviceReader;
deviceWriter = audioDeviceWriter("SampleRate", deviceReader.SampleRate);

%audio process
scope = timescope(...
    "SampleRate",deviceReader.SampleRate, ...
    "TimeSpan",5, ...
    "BufferLength",deviceReader.SampleRate*2*2, ...
    "YLimits",[-1,1], ...
    "TimeSpanOverrunAction", "Scroll");

%main func
disp("Begin Input...")
tic
while(toc<5)
    mySignal = deviceReader();
    deviceWriter(mySignal);
    scope(mySignal)
end
disp("End Input...")

release(deviceReader)
release(deviceWriter)
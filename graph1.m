load mtlb
data = mtlb;
sound(data, Fs);

subplot(2,1,1);
plot(data);
xlabel("時間[sample]");
xlim([1 length(data)]);
ylabel("振動");
subplot(2,1,2);
spectrogram(data, hamming(64), 32, 256, Fs, "yaxis");
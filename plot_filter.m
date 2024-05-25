function plot_filter(filter, cols, labels, index)
%PLOT_FILTER Plots response for specified filter
%   Detailed explanation goes here
rows = 3;
[H, W] = freqz(filter, 1, 3000);

subplot(rows, cols, index);
plot(W / pi, abs(H));
xlabel('Frecventa normalizata');
ylabel('Amplitudine liniar');
title(sprintf("Spectrul liniar pentru %s", labels));

subplot(rows, cols, index + cols);
plot(W / pi, mag2db(abs(H)));
xlabel('Frecventa normalizata');
ylabel('Amplitudine [dB]');
title(sprintf("Spectrul in dB pentru %s", labels));

subplot(rows, cols, index + cols * 2);
plot(W / pi, unwrap(angle(H)));
xlabel('Frecventa normalizata');
ylabel('Faza [rad]');
title(sprintf("Faza pentru %s", labels));

end


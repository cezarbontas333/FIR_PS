function [H, W] = plot_filter(filter, cols, labels, index, omega_s, omega_p)
%PLOT_FILTER Plots response for specified filter
%   Creates a plot containing subplots for frequency responses in linear,
%   dB scaling and angles. Parameter cols is used to know how many
%   responses there are needed to be plotted on the same graphic.
rows = 3;
[H, W] = freqz(filter, 1, 3000);

hold on

subplot(rows, cols, index);
plot(W / pi, abs(H));
xline(omega_p / pi, 'g--');
xline(omega_s /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine liniar');
title(sprintf("Spectrul liniar pentru %s", labels));

subplot(rows, cols, index + cols);
plot(W / pi, mag2db(abs(H)));
xline(omega_p / pi, 'g--');
xline(omega_s /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine [dB]');
title(sprintf("Spectrul in dB pentru %s", labels));

subplot(rows, cols, index + cols * 2);
plot(W / pi, unwrap(angle(H)));
xline(omega_p / pi, 'g--');
xline(omega_s /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Faza [rad]');
title(sprintf("Faza pentru %s", labels));

hold off

end


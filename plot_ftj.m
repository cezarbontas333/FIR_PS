function [h] = plot_ftj(M, omega_p, omega_s, K, cols, index)
%PLOT_FTJ Summary of this function goes here
%   Detailed explanation goes here
rows = 3;
[h, pr] = firls_FTJ_c(M, omega_p / pi, omega_s / pi, K);
[H, W] = freqz(h, 1, 3000);
[GD, WD] = grpdelay(h, 1, 3000);

hold on

subplot(rows, cols, index);
plot(W, abs(H));
xline(omega_p, 'g--');
xline(omega_s, 'r--');
xlabel('Frecventa');
ylabel('Amplitudine liniar');
title(sprintf("Spectrul liniar pentru K=%d, PR=%.2f%%", K, pr));

subplot(rows, cols, index + cols);
plot(WD, abs(GD));
xline(omega_p, 'g--');
xline(omega_s, 'r--');
xlabel('Frecventa');
ylabel('Amplitudine intarziere');
title(sprintf("Spectrul intarzierii"));

subplot(rows, cols, index + cols * 2);
stem(h);
title(sprintf("Secventa pondere"));

hold off
end


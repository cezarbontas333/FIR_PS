function fig_ratio = plot_ratios(H, H_pond, W, W_pond, omega_p, omega_s, type, ratio, ratio_pond)
%PLOT_RATIOS Plots frequencies responses to compare ratios
%   
fig_ratio = figure('Name', sprintf('Comparatie ratii dintre %s', type));
sgtitle(sprintf('Comparatie ratii dintre %s', type));
hold on

subplot(1, 2, 1);
plot(W / pi, abs(H));
xline(omega_p / pi, 'g--');
xline(omega_s /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine');
title(sprintf("Spectrul pentru %s, ratio=%.2f", type, ratio));

subplot(1, 2, 2);
plot(W_pond / pi, abs(H_pond));
xline(omega_p / pi, 'g--');
xline(omega_s / pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine');
title(sprintf("Spectrul pentru %s (ponderat), ratio=%.2f", type, ratio_pond));

hold off

end


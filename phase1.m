%% Date proiect
addpath("dependencies\");
ng = 4;
ns = 4;
fig_num = 1;
freqz_res = 3000;
[omega_p, omega_s, M] = PS_PRJ_2_Faza_1ab(ng, ns);

% set(groot, 'DefaultFigureUnits', 'pixels');
set(groot, 'DefaultFigurePosition', [20, 20, 1800, 1200]);
% Instructiune initializare proprietati pentru toate graficele (utila sa
% pot sa maximizez dimensiunile ferestrelor. Asta e folosita pentru
% afisarea graficelor intr-un mod corespunzator in live script, si pentru
% export in PDF. Eventual aceste marimi pot fi modificate.

%% Punctul a)
W = [0 omega_p/pi omega_s/pi 1];
A = [1 1 0 0];
fig_firls = figure('Name', 'Raspuns filtre FIRLS');
sgtitle('Raspuns filtre FIRLS');
for index = 1 : length(M)
    h_temp = firls(M(index) - 1, W, A);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index, omega_p, omega_s);
end
exportgraphics(fig_firls, 'figures\fig_firls.png', 'Resolution', 600);

W_deph = [0 (pi-omega_s)/pi (pi-omega_p)/pi 1];
% A = [1 1 0 0];
fig_firls_deph = figure('Name', 'Raspuns filtre FIRLS (defazat)');
sgtitle('Raspuns filtre FIRLS (defazat)');
for index = 1 : length(M)
    h_temp = firls(M(index) - 1, W_deph, A);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index, pi - omega_s, pi - omega_p);
end
exportgraphics(fig_firls_deph, 'figures\fig_firls_deph.png', 'Resolution', 600);

fig_firls_secv = figure('Name', 'Secventa pondere filtre FIRLS');
sgtitle('Secventa pondere filtre FIRLS');
for index = 1 : length(M)
    subplot(length(M), 2, 2 * (index - 1) + 1);
    stem(firls(M(index) - 1, W, A));
    title(sprintf("Ordinul %d", M(index)));

    subplot(length(M), 2, 2 * index);
    stem(firls(M(index) - 1, W_deph, A));
    title(sprintf("Ordinul %d (defazat)", M(index)));
end
exportgraphics(fig_firls_secv, 'figures\fig_firls_secv.png', 'Resolution', 600);

%% Punctul b)
% It seems like the 'remez' function is getting removed, so I won't be
% using it anytime soon.
fig_firpm = figure('Name', 'Raspuns filtre FIRPM');
sgtitle('Raspuns filtre FIRPM');
for index = 1 : length(M)
    h_temp = firpm(M(index) - 1, W, A);
    %h_a(index, :) = h_temp(:);
    % [H_a(index), ang_a(index)] = freqz(h(index), 1, freqz_res);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index, omega_p, omega_s);
end
exportgraphics(fig_firpm, 'figures\fig_firpm.png', 'Resolution', 600);

% A = [1 1 0 0];
fig_firpm_deph = figure('Name', 'Raspuns filtre FIRPM (defazat)');
sgtitle('Raspuns filtre FIRPM (defazat)');
for index = 1 : length(M)
    h_temp = firpm(M(index) - 1, W_deph, A);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index, pi - omega_s, pi - omega_p);
end
exportgraphics(fig_firpm_deph, 'figures\fig_firpm_deph.png', 'Resolution', 600);

fig_firpm_secv = figure('Name', 'Secventa pondere filtre FIRPM');
sgtitle('Secventa pondere filtre FIRPM');
for index = 1 : length(M)
    subplot(length(M), 2, 2 * (index - 1) + 1);
    stem(firpm(M(index) - 1, W, A));
    title(sprintf("Ordinul %d", M(index)));

    subplot(length(M), 2, 2 * index);
    stem(firpm(M(index) - 1, W_deph, A));
    title(sprintf("Ordinul %d (defazat)", M(index)));
end
exportgraphics(fig_firpm_secv, 'figures\fig_firpm_secv.png', 'Resolution', 600);

%% Punctul c)
M_c = PS_PRJ_2_Faza_1c(ng, ns);
h_ls = firls(M_c -1, W, A);
h_ls_deph = firls(M_c -1, W_deph, A);
h_pm = firpm(M_c -1, W, A);
h_pm_deph = firpm(M_c -1, W_deph, A);

fig_1c = figure('Name', 'Comparatie raspunsuri FIRLS vs FIRPM');
sgtitle('Comparatie raspunsuri pt filtre FIRLS vs FIRPM');
[H_ls, W_ls] = plot_filter(h_ls, 4, 'LS', 1, omega_p, omega_s);
[H_ls_deph, W_ls_deph] = plot_filter(h_ls_deph, 4, 'LS (defazat)', 2, pi - omega_s, pi - omega_p);
[H_pm, W_pm] = plot_filter(h_pm, 4, 'PM', 3, omega_p, omega_s);
[H_pm_deph, W_pm_deph] = plot_filter(h_pm_deph, 4, 'PM (defazat)', 4, pi - omega_s, pi - omega_p);

% Finding the minimal loss of each filter
passband_ls = W_ls(W_ls < omega_p) / pi;
passband_ls_deph = W_ls_deph(W_ls_deph < pi - omega_s) / pi;
passband_pm = W_pm(W_pm < omega_p) / pi;
passband_pm_deph = W_pm_deph(W_pm_deph < pi - omega_s) / pi;

stopband_ls = W_ls(W_ls > omega_s) / pi;
stopband_ls_deph = W_ls_deph(W_ls_deph > pi - omega_p) / pi;
stopband_pm = W_pm(W_pm > omega_s) / pi;
stopband_pm_deph = W_pm_deph(W_pm_deph > pi - omega_p) / pi;

arr_ripples(1) = max(findpeaks(mag2db(abs(H_ls(length(H_ls) - length(stopband_ls) : end)))));
arr_ripples(2) = max(findpeaks(mag2db(abs(H_ls_deph(length(H_ls_deph) - length(stopband_ls_deph) : end)))));
arr_ripples(3) = max(findpeaks(mag2db(abs(H_pm(length(H_pm) - length(stopband_pm) : end)))));
arr_ripples(4) = max(findpeaks(mag2db(abs(H_pm_deph(length(H_pm_deph) - length(stopband_pm_deph) : end)))));

sprintf('FAZA 1 PUNCTUL c), REZULTATE:\n')
sprintf('Atenuarea FIRLS: %f [dB]\nAtenuarea FIRPM: %f [dB]\n', ...
    arr_ripples(1), arr_ripples(3))
sprintf('(Pentru filtrele defazate)\nAtenuarea FIRLS: %f [dB]\nAtenuarea FIRPM: %f [dB]\n', ...
    arr_ripples(2), arr_ripples(4))

fig_loss = figure('Name', 'Comparatie atenuare FIRLS vs FIRPM');
sgtitle('Comparatie atenuare FIRLS vs FIRPM');
hold on

subplot(1, 2, 1);
plot(W_ls / pi, mag2db(abs(H_ls)));
xline(omega_p / pi, 'g--');
xline(omega_s /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine [dB]');
title(sprintf("Spectrul in dB pentru FIRLS, ALS=%.2f[dB]", arr_ripples(1)));

subplot(1, 2, 2);
plot(W_pm / pi, mag2db(abs(H_pm)));
xline(omega_p / pi, 'g--');
xline(omega_s /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine [dB]');
title(sprintf("Spectrul in dB pentru FIRPM, APM=%.2f[dB]", arr_ripples(3)));

hold off
exportgraphics(fig_loss, 'figures\fig_loss.png', 'Resolution', 600);

fig_loss_deph = figure('Name', 'Comparatie atenuare FIRLS vs FIRPM (defazat)');
sgtitle('Comparatie atenuare FIRLS vs FIRPM (defazat)');
hold on

subplot(1, 2, 1);
plot(W_ls_deph / pi, mag2db(abs(H_ls_deph)));
xline((pi - omega_s) / pi, 'g--');
xline((pi - omega_p) /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine [dB]');
title(sprintf("Spectrul in dB pentru FIRLS, ALS=%.2f[dB]", arr_ripples(2)));

subplot(1, 2, 2);
plot(W_pm_deph / pi, mag2db(abs(H_pm_deph)));
xline((pi - omega_s) / pi, 'g--');
xline((pi - omega_p) /pi, 'r--');
xlabel('Frecventa normalizata');
ylabel('Amplitudine [dB]');
title(sprintf("Spectrul in dB pentru FIRPM, APM=%.2f[dB]", arr_ripples(4)));

hold off
exportgraphics(fig_loss_deph, 'figures\fig_loss_deph.png', 'Resolution', 600);

%% Punctul d)
ws = PS_PRJ_2_Faza_1d(ng, ns);
ws = [1 ws];
h_ls_pond = firls(M_c -1, W, A, ws);
h_ls_deph_pond = firls(M_c -1, W_deph, A, ws);
h_pm_pond = firpm(M_c -1, W, A, ws);
h_pm_deph_pond = firpm(M_c -1, W_deph, A, ws);

fig_1d = figure('Name', 'Comparatie raspunsuri FIRLS vs FIRPM ponderate');
sgtitle('Comparatie raspunsuri pentru filtre FIRLS vs FIRPM ponderate');
[H_ls_pond, W_ls_pond] = plot_filter(h_ls_pond, 4, 'LS', 1, omega_p, omega_s);
[H_ls_deph_pond, W_ls_deph_pond] = plot_filter(h_ls_deph_pond, 4, 'LS (defazat)', 2, pi - omega_s, pi - omega_p);
[H_pm_pond, W_pm_pond] = plot_filter(h_pm_pond, 4, 'PM', 3, omega_p, omega_s);
[H_pm_deph_pond, W_pm_deph_pond] = plot_filter(h_pm_deph_pond, 4, 'PM (defazat)', 4, pi - omega_s, pi - omega_p);

% Finding the stopping bands for each filter
stopband_ls_pond = W_ls_pond(W_ls_pond > omega_s) / pi;
stopband_ls_deph_pond = W_ls_deph_pond(W_ls_deph_pond > pi - omega_p) / pi;
stopband_pm_pond = W_pm_pond(W_pm_pond > omega_s) / pi;
stopband_pm_deph_pond = W_pm_deph_pond(W_pm_deph_pond > pi - omega_p) / pi;

% The same but for passing bands
passband_ls_pond = W_ls_pond(W_ls_pond < omega_p) / pi;
passband_ls_deph_pond = W_ls_deph_pond(W_ls_deph_pond < pi - omega_s) / pi;
passband_pm_pond = W_pm_pond(W_pm_pond < omega_p) / pi;
passband_pm_deph_pond = W_pm_deph_pond(W_pm_deph_pond < pi - omega_s) / pi;

ratio_std(1) = calc_ratio_std(H_ls, stopband_ls, passband_ls);
ratio_std(2) = calc_ratio_std(H_ls_deph, stopband_ls_deph, passband_ls_deph);
ratio_std(3) = calc_ratio_std(H_pm, stopband_pm, passband_pm);
ratio_std(4) = calc_ratio_std(H_pm_deph, stopband_pm_deph, passband_pm_deph);
ratio_std(5) = calc_ratio_std(H_ls_pond, stopband_ls_pond, passband_ls_pond);
ratio_std(6) = calc_ratio_std(H_ls_deph_pond, stopband_ls_deph_pond, passband_ls_deph_pond);
ratio_std(7) = calc_ratio_std(H_pm_pond, stopband_pm_pond, passband_pm_pond);
ratio_std(8) = calc_ratio_std(H_pm_deph_pond, stopband_pm_deph_pond, passband_pm_deph_pond);

sprintf('FAZA 1 PUNCTUL d), REZULTATE:\n')
sprintf('Raportul dispersiilor pentru FIRLS: %f vs FIRLS ponderat: %f\n', ...
    ratio_std(1), ratio_std(5))
sprintf('Raportul dispersiilor pentru (defazat) FIRLS: %f vs FIRLS ponderat: %f\n', ...
    ratio_std(2), ratio_std(6))
sprintf('Raportul dispersiilor pentru FIRPM: %f vs FIRPM ponderat: %f\n', ...
    ratio_std(3), ratio_std(7))
sprintf('Raportul dispersiilor pentru (defazat) FIRPM: %f vs FIRPM ponderat: %f\n', ...
    ratio_std(4), ratio_std(8))

fig_ratio_ls = plot_ratios(H_ls, H_ls_pond, W_ls, W_ls_pond, omega_p, omega_s, ...
    'FIRLS', ratio_std(1), ratio_std(5));
exportgraphics(fig_ratio_ls, 'figures\fig_ratio_ls.png', 'Resolution', 600);
fig_ratio_pm = plot_ratios(H_pm, H_pm_pond, W_pm, W_pm_pond, omega_p, omega_s, ...
    'FIRPM', ratio_std(2), ratio_std(6));
exportgraphics(fig_ratio_pm, 'figures\fig_ratio_pm.png', 'Resolution', 600);
fig_ratio_ls_deph = plot_ratios(H_ls_deph, H_ls_deph_pond, W_ls_deph, W_ls_deph_pond, pi-omega_s, pi-omega_p, ...
    'FIRLS (defazat)', ratio_std(3), ratio_std(7));
exportgraphics(fig_ratio_ls_deph, 'figures\fig_ratio_ls_deph.png', 'Resolution', 600);
fig_ratio_pm_deph = plot_ratios(H_pm_deph, H_pm_deph_pond, W_pm_deph, W_pm_deph_pond, pi-omega_s, pi-omega_p, ...
    'FIRPM (defazat)', ratio_std(4), ratio_std(8));
exportgraphics(fig_ratio_pm_deph, 'figures\fig_ratio_pm_deph.png', 'Resolution', 600);

%% Punctul e)
% TODO

%% Salvare date
save("omegas.mat", "omega_s", "omega_p");
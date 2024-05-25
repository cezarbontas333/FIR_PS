%% Date proiect
addpath("dependencies\");
ng = 4;
ns = 4;
fig_num = 1;
freqz_res = 3000;
[omega_p, omega_s, M] = PS_PRJ_2_Faza_1ab(ng, ns);

%% Punctul a)
W = [0 omega_p/pi omega_s/pi 1];
A = [1 1 0 0];
fig_firls = figure('Name', 'Raspuns filtre FIRLS');
sgtitle('Raspuns filtre FIRLS');
for index = 1 : length(M)
    h_temp = firls(M(index) - 1, W, A);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index);
end

W_deph = [0 (pi-omega_s)/pi (pi-omega_p)/pi 1];
% A = [1 1 0 0];
fig_firls_deph = figure('Name', 'Raspuns filtre FIRLS (defazat)');
sgtitle('Raspuns filtre FIRLS (defazat)');
for index = 1 : length(M)
    h_temp = firls(M(index) - 1, W_deph, A);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index);
end

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

%% Punctul b)
% It seems like the 'remez' function is getting removed, so I won't be
% using it anytime soon.
fig_firpm = figure('Name', 'Raspuns filtre FIRPM');
sgtitle('Raspuns filtre FIRPM');
for index = 1 : length(M)
    h_temp = firpm(M(index) - 1, W, A);
    %h_a(index, :) = h_temp(:);
    % [H_a(index), ang_a(index)] = freqz(h(index), 1, freqz_res);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index);
end

% A = [1 1 0 0];
fig_firpm_deph = figure('Name', 'Raspuns filtre FIRPM (defazat)');
sgtitle('Raspuns filtre FIRPM (defazat)');
for index = 1 : length(M)
    h_temp = firpm(M(index) - 1, W_deph, A);
    plot_filter(h_temp, length(M), sprintf("Ordinul %d", M(index)), index);
end

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

%% Punctul c)
M_c = PS_PRJ_2_Faza_1c(ng, ns);
h_ls = firls(M_c -1, W, A);
h_ls_deph = firls(M_c -1, W_deph, A);
h_pm = firpm(M_c -1, W, A);
h_pm_deph = firpm(M_c -1, W_deph, A);

fig_1c = figure('Name', 'Comparatie raspunsuri FIRLS vs FIRPM');
sgtitle('Comparatie raspunsuri pt filtre FIRLS vs FIRPM');
plot_filter(h_ls, 4, 'LS', 1);
plot_filter(h_ls_deph, 4, 'LS (defazat)', 2);
plot_filter(h_pm, 4, 'PM', 3);
plot_filter(h_pm_deph, 4, 'PM (defazat)', 4);

% Finding the minimal loss of each filter
sprintf('Atenuarea FIRLS: %f [dB]\nAtenuarea FIRPM: %f [dB]\n', )
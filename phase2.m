%% Punctul a) si b)
% Se ruleaza "phase1.m" ca sa avem datele pentru faza 2.
% Sunt unite aceste 2 puncte pentru ca modificarea functiei "firls_FTJ_c.m"
% este singura problema de facut, restul subpunctului fiind identic.
load("omegas.mat");
addpath("dependencies\");
ng = 4;
ns = 4;

M = 20;
K = [5 7 10 13 15];
W = [0 omega_p omega_s 1];
W_deph = [0 pi-omega_s pi-omega_p 1];
A = [1 1 0 0];

fig_ftj = figure('Name', 'Filtre FIRLS');
sgtitle('Filtre FIRLS pentru intarzieri diferite');
filters = zeros(length(K), M);
for i = 1 : length(K)
    filters(i, :) = plot_ftj(M - 1, omega_p, omega_s, K(i), length(K), i);
end
exportgraphics(fig_ftj, 'figures\fig_ftj.png', 'Resolution', 600);

fig_ftj_deph = figure('Name', 'Filtre FIRLS (defazate)');
sgtitle('Filtre FIRLS pentru intarzieri diferite (defazate)');
filters_deph = zeros(length(K), M);
for i = 1 : length(K)
    filters_deph(i, :) = plot_ftj(M - 1, pi - omega_s, pi - omega_p, K(i), length(K), i);
end
exportgraphics(fig_ftj_deph, 'figures\fig_ftj_deph.png', 'Resolution', 600);
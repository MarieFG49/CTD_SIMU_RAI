
%% Simulation d'un traitement par RAI
% Configuration des paramètres
Nbre = 8; % Nombre de fractions/runs [1,8]
Lag = 3; % En mois, délai entre les fractions/runs (supposé constant)
Dose = 3.7; % En Gbq, Activité par run d'irathérapie
color = [1, 0, 0]; % Couleur du plot (rouge, par exemple)
% Appel de la fonction Demonstrateur98f
figure; % Créer une nouvelle figure
hold on; % Permet de maintenir les tracés dans la figure
curveHandle = Demonstrateur98f(Nbre, Lag, Dose, color);
% Ajout d'une légende
legend(curveHandle, ...
       {sprintf('Nbre = %d, Lag = %d, Dose = %.1f', Nbre, Lag, Dose)}, ...
       'Location', 'northwest');

% Mise en forme du graphique
xlabel('Time in months');
ylabel('Tg(t) (Unitless)');
title('Simulation Tg(t) avec paramètres choisis');
grid on;
hold off;
%% Influence du nombre de fractions
clear;
figure;
% Paramètres fixes
Lag = 3; % En mois, délai entre les fractions/runs (supposé constant)
Dose = 3.7; % En Gbq, Activité par run d'irathérapie
Nbre = 8; % Nombre de fractions/runs
hold on; % Garder toutes les courbes sur la même figure
% Palette de couleurs pour chaque fraction
Colors = jet(Nbre); % Génère une palette de couleurs arc-en-ciel
% Préallocation pour stocker les objets des courbes
curveHandles = gobjects(1, Nbre);
for i = 1:Nbre
    % Tracer chaque fraction avec une couleur distincte
    curveHandles(i) = Demonstrateur98f(i, Lag, Dose, Colors(i, :));
end
% Légende automatique
legendStrings = arrayfun(@(x) sprintf('%d Frac', x), 1:Nbre, 'UniformOutput', false);
legend(curveHandles, legendStrings, 'Location', 'northwest');
% Mise en forme du graphique
xlabel('Time in months');
ylabel('Tg(t) (Unitless)');
title('Tg(t) simulation for different fractions');
grid on;
hold off;
%% Influence du Lag
clear;
figure;
Dose = 3.7; % En Gbq, Activité par run d'irathérapie
Nbre = 8; % Nombre de fractions/runs [1,8]
hold on; % Garder toutes les courbes sur la même figure
% Palette de couleurs arc-en-ciel pour chaque valeur de Lag
LagColors = jet(8); % Génère une palette avec 8 couleurs du rouge au bleu
% Préallocation pour stocker les objets des courbes
curveHandles = gobjects(1, 8);
for i = 1:8 % En mois, délai entre les fractions/runs (supposé constant)
    % Passer la couleur correspondant à Lag `i` à Demonstrateur98f
    curveHandles(i) = Demonstrateur98f(Nbre, i, Dose, LagColors(i, :));
end
% Légende automatique avec les bonnes couleurs
legend(curveHandles, arrayfun(@(x) sprintf('Lag = %d', x), 1:8, 'UniformOutput', false), ...
    'Location', 'northwest');
% Mise en forme de la figure
xlabel('Time in months');
ylabel('Tg(t) (Unitless)');
title('Tg(t) simulation for different Lag values');
grid on;
hold off;
%% Influence de l'activité par fraction
clear;
figure;
% Paramètres fixes
Lag = 3; % En mois, délai entre les fractions/runs (supposé constant)
Nbre = 8; % Nombre de fractions/runs [1,8]
% Palette de couleurs pour chaque courbe
Colors = jet(8); % Génère une palette de 8 couleurs allant du rouge au bleu
% Préallocation pour capturer les handles des courbes
curveHandles = gobjects(1, 8);
% Boucle pour tracer chaque courbe
hold on; % Garder toutes les courbes sur la même figure
for i = 1:8
    Dose = i; % Activité par fraction en GBq (1 à 8 GBq)
    % Tracer la courbe avec une couleur unique
    curveHandles(i) = Demonstrateur98f(Nbre, Lag, Dose, Colors(i, :));
end
% Ajout de la légende
legendStrings = arrayfun(@(x) sprintf('A=%dGBq', x), 1:8, 'UniformOutput', false);
legend(curveHandles, legendStrings, 'Location', 'northwest');
% Mise en forme du graphique
xlabel('Time in months');
ylabel('Tg(t) (Unitless)');
title('Tg(t) simulation for different fractional activity');
grid on;
hold off;

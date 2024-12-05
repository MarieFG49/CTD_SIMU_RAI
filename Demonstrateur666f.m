function curveHandle = Demonstrateur666f(Nbre, Lag, Dose, color)
% Démonstrateur Tg=f(#séances; intervalle entre les séances; dose par fraction; couleur)

% Définition des Paramètres
Td = 66.6;               % Temps de doublement tumoral (mois)
r0 = 0.00407;           % Rendement
a = 0.0169;             % Taux d'efficacité de l'iode
lbda = 0.00000000386;   % Pouvoir de sécrétion Tg
ke = 0.319;             % Taux d'élimination naturelle de Tg

% Conditions Initiales
N00 = 1.12E9;  % Nombre initial de cellules tumorales
Tg00 = 100;    % Dosage initial de Tg (ng/ml)
A00 = 0;       % Activité initiale de l'iode (GBq)

% Boucle pour chaque fraction
for i = 1:Nbre 
    syms Tg(t) N(t) A(t) Tg_2(t)

    % Résolution des équations différentielles
    ode1 = diff(A) == -a*log(2)*A;
    cond1 = A(0) == Dose + A00;
    A(t) = dsolve(ode1, cond1);

    ode2 = diff(N) == N*(log(2)/Td) - r0*A(t)*N;
    cond2 = N(0) == N00;
    N(t) = dsolve(ode2, cond2);

    ode3 = diff(Tg) == lbda*N(t) - ke*Tg;
    cond3 = Tg(0) == Tg00;
    Tg(t) = dsolve(ode3, cond3);

    Tg_2(t) = Tg(t - (i-1)*Lag);

    % Mise à jour des conditions initiales
    N00 = vpa(subs(N, t, Lag));
    Tg00 = vpa(subs(Tg, t, Lag));
    A00 = vpa(subs(A, t, Lag));

    % Tracé de la courbe pour la fraction actuelle
    hold on;
    fplot(Tg_2, [(i-1)*Lag, i*Lag], 'Color', color); % Utiliser la couleur passée
    axis([0 80 0 100]);
end

% Tracé pour la dernière fraction
curveHandle = fplot(Tg_2, [(Nbre)*Lag, 80], 'Color', color);

% Mise en forme
xlabel('Time in months');
ylabel('Tg(t) (Unitless)');
grid on;
end

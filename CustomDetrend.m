function ImZdt = CustomDetrend(ImZ, m)
% Detrend mediante interpolazione di un piano:
% z = a1 * x + a2 * y + a3
%
% Input:
% - ImZ = scansione rettangolare in forma di matrice
%   nei cui valori ci sono le quote Z misurate con il laser
% - m = numero di punti da usare per l'interpolazione
% 
% Output: 
% - ImZdt = scansione cui viene sottratto il piano

Nr = size(ImZ,1); % #righe
Nc = size(ImZ,2); % #colonne
ImZdt = zeros(Nr,Nc); % inizializziamo la matrice di uscita

A = zeros(m, 3); % inizializziamo la matrice A
b = ones(m, 1);  % inizializziamo il vettore b

% Costruiamo la matrice A ed il vettore b
% tramite 'm' punti campionati casualmente
for i = 1:m
    rr = ceil(rand * Nr);
    cc = ceil(rand * Nc);
    % DA FARE: costruire la riga i-esima di A
    ...;
    % DA FARE: costruire il valore i-esimo di b    
    ...;
end

% DA FARE: calcolare x: A x = b
x = ...;

a1 = x(1);
a2 = x(2);
a3 = x(3);

% DETREND: togliamo ai valori di ImZ il piano interpolante 
% appena identificato:
for rr = 1:Nr
    for cc = 1:Nc
        % DA FARE: sottrarre il piano
        ImZdt(rr,cc) = ImZ(rr,cc) - ...;
    end
end

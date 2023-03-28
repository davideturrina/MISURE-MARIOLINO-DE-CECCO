function [GaussPDFMatch, ShapeFactor, Kur, Skew] ...
    = GaussFIT(scan, plotta)
% Funzione per calcolare il matching con densità gaussiana
% della scansione "scan" ed altri indicatori statistici. 
% 
% Input:
% - scan = scansione (può essere una linea o una patch rettangolare
% costituita da più linee)
% - plotta
% 
% Output: 
% - GaussPDFMatch = errore quadratico medio tra PDF dei dati ("scan")
% e gaussiana equivalente (avente stesso valor medio e dev standard)
% - ShapeFactor = dev-std / mean(abs(scan))
% - Kur = kurtosis
% - Skew = Skew factor

% https://it.mathworks.com/help/predmaint/ug/signal-features.html

% Debug section (commenta righe 1 e 2, scommenta 22-30 ed esegui):
% Carico dati Lamiera 2:
% im = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/Plate2Picture.jpeg');
% imdata = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/ZImagePlate2.tif');
% imdata = imdata(:, 550:end);
% figure(1), imagesc(im);
% figure(2), imagesc(imdata);
% Colonna = 25;
% scan = imdata(:,Colonna);
% Se necessario rimuovere gli outlier su questa colonna
% plotta = 1;

if size(scan,1) > 1 || size(scan,2) > 1 % una matrice
    scan2plot = scan;
    % If the scan is a matrix it reshapes to a vecror:
    scan = reshape(scan,[],1);
end

% Extraiamo media e dev-std della scansione:
m = mean(scan);
s = std(scan);
% Definiamo gli intervalli su cui calcolare l'istogramma o PDF
X = m - 3*s : s/3 : m + 3*s;

% Calcoliamo i valori della PDF (Densità di probabilità) in 
% corrispondenza degli intervalli definiti da X:
Hist = histogram(scan, X, 'Normalization','pdf');
Hv = Hist.Values;

% Compute a Normal statistics with same mu and sigma
% Calcoliamo i valori sempre negli intervalli X di una PDF
% normale:
Xc = (X(2:end) + X(1:end-1))/2; % centri degli intervalli
HNormalv = normpdf(Xc, m, s);

% se si vogliono plottare i risultati:
if plotta == 1
    figure(1000), plot(Hv, 'r')
    hold on, plot(HNormalv, 'b')
    
    if size(scan,1) > 1 && size(scan,2) > 1
        figure(1001), imagesc(scan2plot);
    else
        figure(1001), plot(scan);
    end
end

% Fitting Gaussiana
% DA FARE: calcolare gli errori quadratici medi tra le due PDF:
GaussPDFMatch = immse(Hv,HNormalv);

% Shape Factor:
ShapeFactor = s / mean(abs(scan));

% Kurtosis 
% (The kurtosis has a value of 3 for a normal distribution)
% DA FARE: calcolare la kurtosis dei dati "scan":
Kur = kurtosis(scan);

% Skewness or degree of asymmetry:
% (The skewness has a value of 0 for a normal distribution)
% DA FARE: calcolare lo Skew factor dei dati "scan":
Skew = skewness(scan);


    
    

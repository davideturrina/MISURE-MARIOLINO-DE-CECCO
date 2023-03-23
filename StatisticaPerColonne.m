%% STEP 1: Lettura dati
close all
clear

% NOTA: 
% - nel file "*.jpeg" c'è una foto scattata con smartphone
% - nel file "*.tif" i dati misurati con laser a triangolazione
% in forma di una immagine con valori di ciascun pixel pari 
% alle quote lungo la verticale misurate mediante laser

% NOTA: inserire i percorsi corretti su vostro PC

% Lamiera 1:
% im = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Lezioni/1 Misure 1 2023/Materiale del Corso/4 Misure di Forma e Diagnostica 3D/Matlab/Ritagliati Matteo/Plate1Picture.jpeg');
% imdata = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Lezioni/1 Misure 1 2023/Materiale del Corso/4 Misure di Forma e Diagnostica 3D/Matlab/Ritagliati Matteo/ZImagePlate1.tif');
% imdata = imdata(:, 300:end);

% Lamiera 2:
im = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/Plate2Picture.jpeg');
imdata = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/ZImagePlate2.tif');
imdata = imdata(:, 550:end);

% Lamiera 3:
% im = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/Plate3Picture.jpeg');
% imdata = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/ZImagePlate3.tif');
% imdata = imdata(:, 220:(end-200));

% Lamiera 4:
% im = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/Plate4Picture.jpeg');
% imdata = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/ZImagePlate4.tif');

% NOTA: 
% - nella matrice "im" c'è la foto scattata con smartphone
% - nella matrice "imdata" ci sono i dati misurati con laser a 
% triangolazione lungo la verticale


figure(1), imagesc(im);
figure(2), imagesc(imdata);


%% STEP 2: Rimozione Outlier
% NOTA: in corrispondenza delle colonne della CCD in cui il laser
% a triangolazione non rileva bene il picco si generano 
% dei valori non corretti che è possibile considerare outlier

% creaiamo una matrice di dimensione uguale ad imdata:
ImmagineZ = zeros(size(imdata));

% per ogni riga andiamo a rimuovere gli outlier:
for i = 1:1:size(imdata,1)
    % usiamo la variabile di appoggio "scansione" per 
    % estrarre le righe ed effettuare la rimozione outlier:
    scansione = imdata(i,:);
    scansione = double(scansione) * 1000; % to double [mm] for filtering

    % Rimozione Outlier viene fatta qui:
    % DA FARE: usare il comando "hampel"
    scansione = ...;
    scansione = scansione - mean(scansione);
    
    % DA FARE: assegniamo alla riga della nuova matrice "ImmagineZ"
    ...
end
    
figure(3), imagesc(ImmagineZ);

% dati guardati di lato:
figure(4), hold on
for i = 1:1:size(imdata,1)
    plot(ImmagineZ(i,:))
end

%% STEP 3: - Valutazione statistica x colonne

% creaimo una matrice con #righe = #colonne di imdata
% e 4 colonne per immagazzinare i 4 indicatori:
% 1. fitting con gaussiana corrispondente
% 2. ShapeFactor
% 3. Kurtosis
% 4. Skew Factor
GtestC = zeros(size(imdata, 2), 4);
for i = 1:1:size(ImmagineZ, 2)
    
    % Detrend viene fatta qui:
    % DA FARE: usare comando "detrend" provando diversi 
    % ordini del polinomio e restituite la colonna i-esima
    % su cui avete tolto il trend in una variabile "Column"
    Column = ...;
    
    % DA FARE: completare la funzione GaussFIT 
    [GaussPDFMatch, ShapeFactor, Kur, Skew] = ...
        GaussFIT(Column, 0);
    GtestC(i,1) = GaussPDFMatch;
    GtestC(i,2) = ShapeFactor;
    GtestC(i,3) = Kur;
    GtestC(i,4) = Skew;    
end

figure(5), title('Per colonne')
subplot(4, 1, 1), plot(GtestC(:,1)), title('Gauss Fit')
subplot(4, 1, 2), plot(GtestC(:,2)), title('ShapeFactor')
subplot(4, 1, 3), plot(GtestC(:,3)), title('Kurtosis')
subplot(4, 1, 4), plot(GtestC(:,4)), title('Skew Factor')


%% STEP 4: - Valutazione statistica x righe
ImmagineZ = ImmagineZ';

% DA FARE: verificare se le impostazioni tenute per le 
% colonne van bene anche per le righe (ad esempio per il
% detrend)


GtestR = zeros(size(imdata,2), 4);
for i = 1:1:size(ImmagineZ, 2)
    Column = detrend(ImmagineZ(:,i));
    [GaussPDFMatch, ShapeFactor, Kur, Skew] = ...
        GaussFIT(Column, 0);
    GtestR(i,1) = GaussPDFMatch;
    GtestR(i,2) = ShapeFactor;
    GtestR(i,3) = Kur;
    GtestR(i,4) = Skew;    
end

figure(6), title('Per righe')
subplot(4, 1, 1), plot(GtestR(:,1)), title('Gauss Fit')
subplot(4, 1, 2), plot(GtestR(:,2)), title('ShapeFactor')
subplot(4, 1, 3), plot(GtestR(:,3)), title('Kurtosis')
subplot(4, 1, 4), plot(GtestR(:,4)), title('Skew Factor')




%% STEP 1: Lettura dati
% NOTA: 

% - nel file "*.jpeg" c'è una foto scattata con smartphone
% - nel file "*.tif" i dati misurati con laser a triangolazione
% in forma di una immagine con valori di ciascun pixel pari 
% alle quote lungo la verticale misurate mediante laser

% NOTA: inserire i percorsi corretti su vostro PC ---> mettete tutto nella
% cartella del progetto, dovete solo richiamare il nome del file (guardate
% come è stato fatto per la lamiera 1"

% ricordate di fare tutte le operazioni di push e pull una volta finite le
% modifiche.

% Lamiera 2:
%im = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/Plate2Picture.jpeg');
%imdata = imread('/Users/mariolinodececco/Documents/Backup Mario - Gennaio 2021/Progetti Industriali/1 Rocitoo - Automazione/Linee industriali/Visione/BM/Misura difetti Lastre di metallo/Dati/Ritagliati Matteo/ZImagePlate2.tif');
%imdata = imdata(:, 550:end);

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


close all
clear

% ,,,
% Lamiera 1:

im = imread('Plate1Picture.jpeg');
imdata = imread('ZImagePlate1.tif');
imdata = imdata(:, 300:end);

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
    scansione = hampel(scansione, 20);
    scansione = scansione - mean(scansione);
    
    % DA FARE: assegniamo alla riga della nuova matrice "ImmagineZ"
    ImmagineZ(i,:)=scansione;
end

% Convertiamo in [mm]
ImmagineZ = 1000 * ImmagineZ;

figure(3), imagesc(ImmagineZ);



%% STEP 3: Detrend
% DA FARE: detrend qui su intero set di dati oppure
% per ciascuna sottomatrice al passo successivo

% dati/lamiera guardati di "profilo":

figure(312), hold on
for i = 1:1:size(ImmagineZ,1)
    plot(ImmagineZ(i,:))
end
ylim([-4 4]), grid on

% Detrend   
ImmagineZ = detrend(ImmagineZ,1, 500);
figure(313), imagesc(ImmagineZ);

% Togliamo la mediana (meno affetta da outlier
% rispetto alla media):
ImmagineZ = ImmagineZ - median(ImmagineZ,'all');

% dati/lamiera guardati di "profilo":
figure(33), hold on
for i = 1:1:size(ImmagineZ,1)
    plot(ImmagineZ(i,:))
end
ylim([-4 4]), grid on

% DA FARE: provare a plottare le nuvole di punti in 3D
% in modo da apprezzare l'effetto del detrend su grafico 3D
% usare ad esempio il comando "mesh"

figure(34), mesh(ImmagineZ)





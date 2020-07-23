close all;
clear all;
system('python Python_workspace/generate_files.py');
usa = imread('states_square_no_borders.jpg');
usa = rgb2gray(usa);
[x,y] = size(usa);
matrix = zeros(x,y);
for wys=1:y
    for szer=1:x
        if usa(szer,wys) == 0
            matrix(szer,wys) = 0;
        end
        if usa(szer,wys) == 255
            matrix(szer,wys) = 1;
        end
    end
end

figure();
imshow(matrix,[]);
title('Plansza USA 1000x1000');

matrix = transpose(matrix);

indeks = imread('states_square.jpg');
indeks1 = im2bw(indeks,240/255);
indeks1 = transpose(indeks1);

stany_read = readtable('stany_new.xlsx');
stany = table2array(stany_read);
ill = [1 2 3 4 8 11 14 16];
health = [6 7 10 12 13 17];
recovered = [5 9 15 19];
non_exist = [20];
rozmiar = 1000;
epidemia = zeros(rozmiar, rozmiar);
[epidemia, mapa_stanow_usa] = generuj_poczatek('states_square.jpg',rozmiar);
epidemia = transpose(epidemia);
mapa_stanow_usa = transpose(mapa_stanow_usa);
liczbaCykli = 10; 
[rozmiar_x, rozmiar_y] = size(epidemia);
[country_x, country_y] = find(matrix);

for borders_x=1:rozmiar_x
    for borders_y=1:rozmiar_y
        if epidemia(borders_x,borders_y) == 0
            if matrix(borders_x, borders_y) == 0
                epidemia(borders_x,borders_y) = 13;
%                  epidemia(borders_x,borders_y) = 6;
            end
        end
    end
end

for back_x=1:rozmiar_x
   for back_y=1:rozmiar_y
       if matrix(back_x, back_y) == 1
           epidemia(back_x, back_y) = 20;
       end
   end
end

states_number_is_51_leave_me_alone = 51;

for n=1:liczbaCykli 
    epidemia_kopia = epidemia;
    tablica_stanow_usa = {};
    for stan_usa=1:states_number_is_51_leave_me_alone
        tablica_stanow_usa = [tablica_stanow_usa, state_status(epidemia_kopia, mapa_stanow_usa, states_number_is_51_leave_me_alone, stan_usa)];
    end
    tablica_stanow_usa{31} = tablica_stanow_usa{31} + tablica_stanow_usa{26}; %obsługa stanów USA rozbitych na dwie części przez indksację 
    tablica_stanow_usa{42} = tablica_stanow_usa{42} + tablica_stanow_usa{41};
    tablica_stanow_usa{43} = tablica_stanow_usa{43} + tablica_stanow_usa{45};
    [row_ill,col_ill] = find(epidemia == 1 | epidemia == 2 | epidemia == 3 | epidemia == 4 | epidemia == 8 | epidemia == 11 | epidemia == 14 | epidemia == 16);
    [row_health, col_health] = find(epidemia == 6 | epidemia == 7 | epidemia == 10 | epidemia == 12 | epidemia == 13 | epidemia == 17);
    [row_recovered, col_recovered] = find(epidemia == 5 | epidemia == 9 | epidemia == 15 | epidemia == 19);
    [row_death, col_death] = find(epidemia == 18);
    [row_non_exist, col_non_exist] = find(epidemia == 20);
    [row_black, col_black] = find(indeks1 == 0);
    suma = zeros(1,4);
    for s=1:51
        suma = tablica_stanow_usa{s} + suma;
    end
    sumka = 0;
    for t=1:4
        sumka = suma(1,t) + sumka;
    end
    disp('Cykl:');
    disp(n);
    disp('Zdrowi:');
    disp(suma(1,2));
    disp('Chorzy:');
    disp(suma(1,1));
    disp('Wyzdrowiali:');
    disp(suma(1,3));
    disp('Martwi:');
    disp(suma(1,4));
    for back_x=1:rozmiar_x
        for back_y=1:rozmiar_y
            if matrix(back_x, back_y) == 1
                epidemia(back_x, back_y) = 20;
            end
        end
    end
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(row_ill,rozmiar_x-col_ill+1,'.','Marker', 'o', 'MarkerFaceColor', 'r', 'Color', 'r', 'MarkerSize', 2);
    hold on;
    plot(row_death,rozmiar_x-col_death+1,'.','Marker', 'o', 'MarkerFaceColor', 'k', 'Color', 'k', 'MarkerSize', 4);
    hold on;
    plot(row_health,rozmiar_x-col_health+1,'.','Marker', 'o', 'MarkerFaceColor', 'b', 'Color', 'b', 'MarkerSize', 4);
    hold on;
    plot(row_recovered,rozmiar_x-col_recovered+1,'.','Marker', 'o', 'MarkerFaceColor', 'g', 'Color', 'g', 'MarkerSize', 1);
    hold on;
    plot(row_non_exist,rozmiar_x-col_non_exist+1,'.','Marker', 'o', 'MarkerFaceColor', 'w', 'Color', 'w', 'MarkerSize', 1);
    hold on;
    plot(row_black,rozmiar_x-col_black+1,'.','Marker', 'o', 'MarkerFaceColor', 'k', 'Color', 'k', 'MarkerSize', 1);
    axis([1 rozmiar_x 1 rozmiar_x]);
    title(['COVID-19 Cykl: ' num2str(n)]);
    daspect([1,1,1])    
    %text(2,2.5,['cykl ' num2str(n)]);
    hold off;
    saveas(gcf,['cykl_' num2str(n)],'pdf')
    kolejna= zeros(rozmiar_x,rozmiar_x); 
    for w=1:rozmiar_x
        for k=1:rozmiar_x
            sasiedzi_stan = fPoliczSasiadow(epidemia,w,k);
            kolejna(w,k) = zmiana_komorki(sasiedzi_stan, epidemia(w,k), stany);
            if kolejna(w,k) == 5 && kolejna(w,k) == 9 && kolejna(w,k) == 15 && kolejna(w,k) == 19
                disp('Zmiana na zdrowego');
            end
        end
    end
    epidemia= zeros(rozmiar_x,rozmiar_x);
    [row_next, col_next] = find(kolejna);
    liczbaNieZer = length(row_next);
    for m=1:liczbaNieZer
        epidemia(row_next(m),col_next(m)) = kolejna(row_next(m),col_next(m));
    end  
    if liczbaNieZer==0
         disp('FATAL ERROR!');
        break;
    end

end

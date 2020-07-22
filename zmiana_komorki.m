function nowa_komorka = zmiana_komorki(suma, stan_komorki, stany)
[row, col] = size(stany);
ill = [1 2 3 4 8 11 14 16 18];
ill_alive = [1 2 3 4 8 11 14 16];
death = [18];
health = [6 7 10 12 13 17];
recovered = [5 9 15 19];
non_exist = [20];
list = [];
for n=1:col
    if stany(stan_komorki, n) == 1
        list = [list n];
    end 
end
[row_n, col_n] = size(list);
if col_n > 0
    if suma > 0
        if stan_komorki == 20
            nowa_komorka = non_exist(1);
        end
        if stan_komorki == 18
            nowa_komorka = death(1);
        end
        if ismember(stan_komorki,ill_alive)
            [common, pos] = intersect(list,recovered);
            wylosowany_indeks = randperm(length(common),1);
            nowa_komorka = common(wylosowany_indeks);
        end
        if ismember(stan_komorki,health)
            [common, pos] = intersect(list,health);
            wylosowany_indeks = randperm(length(common),1);
            nowa_komorka = common(wylosowany_indeks);
        end
        if ismember(stan_komorki, recovered)
            [common, pos] = intersect(list,recovered);
            wylosowany_indeks = randperm(length(common),1);
            nowa_komorka = common(wylosowany_indeks);
        end
    end       
    if suma <= 0
        if stan_komorki == 20
            nowa_komorka = non_exist(1);
        end
        if stan_komorki == 18
        %if ismember(stan_komorki, death)
            nowa_komorka = death(1);
        end
        if ismember(stan_komorki,ill_alive)
            [common, pos] = intersect(list,ill);
            wylosowany_indeks = randperm(length(common),1);
            nowa_komorka = common(wylosowany_indeks);
        end
        if ismember(stan_komorki,health)
            [common, pos] = intersect(list,ill);
            wylosowany_indeks = randperm(length(common),1);
            nowa_komorka = common(wylosowany_indeks);
        end
        if ismember(stan_komorki, recovered)
            [common, pos] = intersect(list,recovered);
            wylosowany_indeks = randperm(length(common),1);
            nowa_komorka = common(wylosowany_indeks);
        end
    end        
end
if col_n == 0
    nowa_komorka = 18;
end

end
        




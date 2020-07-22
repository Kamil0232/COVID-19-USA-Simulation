function sasiedzi_sprawdz = stany_sasiedzi(cell, lista)
    [rows, colums] = size(lista);
    for stan_komorki=1:colums
        if cell==stan_komorki
            lista(stan_komorki) = lista(stan_komorki)+1;
        end
    end
    sasiedzi_sprawdz = lista;
end
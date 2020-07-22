function [stan_poczatkowy_usa, podzial_na_stany_usa] = generuj_poczatek(plik, rozmiar)

usa_states = ["California", "Oregon", "Washington", "Nevada", "Arizona", "Idaho", "Utah", "Montana", "Wyoming", "New Mexico",...
    "Colorado", "Texas", "Nebraska", "South Dakota", "North Dakota", "Oklahoma", "Kansas", "Minnesota", "Iowa", "Missouri",...
    "Arkansas", "Louisiana", "Wisconsin", "Illinois", "Mississippi", "Michigan", "Tennessee", "Kentucky", "Indiana", "Alabama",...
    "Michigan", "Florida", "Ohio", "Georgia", "North Carolina", "Virginia", "South Carolina", "West Virginia", "Pennsylvania", "New York",...
    "Maryland", "Maryland", "Delaware", "New Jersey", "Delaware", "Vermont", "Massachusetts", "Connecticut", "New Hampshire",...
    "Maine", "Rhode Island"];

[usa_states_map, states_number] = wydzielanie_stanow(plik);

stan_poczatkowy = zeros(rozmiar,rozmiar);
[x_map, y_map] = size(usa_states_map);

files = {};
for stan=1:51
    file_name = 'Stany_USA/' + usa_states(stan) + '.txt';
    state_matrix = importdata(file_name,',');
    files = [files,state_matrix];
end

licznik = zeros(1,51);
for x=1:x_map
    for y=1:y_map
        if usa_states_map(x,y) > 0 
            licznik(usa_states_map(x,y)) = licznik(usa_states_map(x,y)) + 1;
            stan_poczatkowy(x,y) = files{usa_states_map(x,y)}(1,licznik(usa_states_map(x,y)));
        end
    end
end

stan_poczatkowy_usa = stan_poczatkowy;
podzial_na_stany_usa = usa_states_map;

end
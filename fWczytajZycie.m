function planszaZwrotna = fWczytajZycie(plansza,nazwaPliku,x,y)
M = importdata(nazwaPliku,',');
[w, k] = size(M);
for n=1:w
	for m=1:k
		plansza(x+n,y+m) = M(n,m);
	end
end
[wP,kP] = size(plansza);
planszaZwrotna = zeros(wP,kP);
[I,J] = find(plansza);
liczbaNieZer = length(I);
for n=1:liczbaNieZer
    planszaZwrotna(I(n),J(n)) = plansza(I(n),J(n));
end
end


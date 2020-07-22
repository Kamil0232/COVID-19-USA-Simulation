function stan_otoczenia = fPoliczSasiadow(plansza,x,y)
    [w,k] = size(plansza);
    %sasiedzi = zeros(1,19);
    sasiedzi = zeros(1,20);
    if x>1 
        sasiedzi = stany_sasiedzi(plansza(x-1,y),sasiedzi);  
    end
    if y>1
        sasiedzi = stany_sasiedzi(plansza(x,y-1),sasiedzi);
    end
    if x<w  
        sasiedzi = stany_sasiedzi(plansza(x+1,y),sasiedzi);
    end
    if y<k 
        sasiedzi = stany_sasiedzi(plansza(x,y+1),sasiedzi);
    end
    if x>1 && y>1 
        sasiedzi = stany_sasiedzi(plansza(x-1,y-1),sasiedzi);
    end
    if x>1 && y<k 
        sasiedzi = stany_sasiedzi(plansza(x-1,y+1),sasiedzi);
    end
    if x<w && y>1 
        sasiedzi = stany_sasiedzi(plansza(x+1,y-1),sasiedzi);
    end
    if x<w && y<k 
        sasiedzi = stany_sasiedzi(plansza(x+1,y+1),sasiedzi);
    end     
   
s = sasiedzi;

stan_otoczenia = (-10.5)*s(1) + (-10.5)*s(2) + (-10.5)*s(3) + (-10.5)*s(4) + (1.2)*s(5) +...
    (0.8)*s(6) + (0.8)*s(7) + (-1.5)*s(8) + (1.2)*s(9) + (1.2)*s(10)  + (-5)*s(11) +...
    (1.2)*s(12) + (0.5)*s(13) + (-10.5)*s(14) + (2)*s(15) + (-10.5)*s(16) + (2)*s(17) + (2)*s(19) + 0*s(20);
end
  
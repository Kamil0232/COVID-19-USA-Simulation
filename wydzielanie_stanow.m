function [indeksacja_final_product, liczba_stanow] = wydzielanie_stanow(plik)

indeks = imread(plik);
indeks1 = im2bw(indeks,240/255);
[indeksacja2, n2] = bwlabel(indeks1, 8);
[a,b] = size(indeksacja2);

zuc = 0;
list = zeros(1,n2);

for x=1:a
    for y=1:b
        for elem=1:n2
            if indeksacja2(x,y) == elem
                list(elem) = list(elem) + 1;
            end
        end
    end
end
   
for w=1:a
    for z=1:b
        for elem2=1:n2
            if indeksacja2(w,z) == elem2
                if list(elem2) < 40
                    indeksacja2(w,z) = 0;
                end
            end
        end
    end
end

[indeksacja3, n3] = bwlabel(indeksacja2, 8);
[a2,b2] = size(indeksacja3);


indeksacja_final_product = indeksacja3;
liczba_stanow = n3;

end

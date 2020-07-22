function statystyki_stanu_usa = state_status(epidemic_matrix, state_matrix, states_number, badany_stan)

[x_size,y_size] = size(epidemic_matrix);

statystyki_stanu_usa = zeros(1,4); %1 - chorzy, 2 - zdrowi, 3 - wyzdrowiali, 4 - martwi

%for i=1:states_number
    for x=1:x_size
        for y=1:y_size
            if state_matrix(x,y) == badany_stan
                if epidemic_matrix(x,y) == 1 || epidemic_matrix(x,y) == 2 || epidemic_matrix(x,y) == 3 || epidemic_matrix(x,y) == 4 || epidemic_matrix(x,y) == 8 || epidemic_matrix(x,y) == 11 || epidemic_matrix(x,y) == 14 || epidemic_matrix(x,y) == 16
                    statystyki_stanu_usa(1,1) = statystyki_stanu_usa(1,1) + 1;
                end
                if epidemic_matrix(x,y) == 6 || epidemic_matrix(x,y) == 7 || epidemic_matrix(x,y) == 10 || epidemic_matrix(x,y) == 12 || epidemic_matrix(x,y) == 13 || epidemic_matrix(x,y) == 17 
                    statystyki_stanu_usa(1,2) = statystyki_stanu_usa(1,2) + 1;
                end
                if epidemic_matrix(x,y) == 5 || epidemic_matrix(x,y) == 9 || epidemic_matrix(x,y) == 15 || epidemic_matrix(x,y) == 19 
                    statystyki_stanu_usa(1,3) = statystyki_stanu_usa(1,3) + 1;
                end
                if epidemic_matrix(x,y) == 18 
                    statystyki_stanu_usa(1,4) = statystyki_stanu_usa(1,4) + 1;
                end
            end
        end
    end    
%end

end 

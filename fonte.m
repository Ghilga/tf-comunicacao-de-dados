% Entrada: numero de bits a serem simulados
% Saida: vetor com os bits gerados entre 0 e 1
function saida = fonte(num_b)
    saida = randi([0,1], 1, num_b);
end
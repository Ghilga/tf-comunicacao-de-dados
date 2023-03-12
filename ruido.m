% NA: vetor de amplitudes do ruido
% type: tipo de ruido
% num_bits_codif: numero de bits do sinal codificado
% M: numero de bits por símbolo
% i: indice do vetor de amplitudes
function saida = ruido(NA, type, num_bits_codif, M, i)
    if(type == 1)
        saida = NA(i) *complex(randn(1, num_bits_codif/M), randn(1, num_bits_codif/M))*sqrt(0.5);
    end
    if(type == 2)  %Ruido Gaussiano Branco 
        ruido = awgn(NA, 2, -5); %sinal de entrada, relação sinal-ruído e potência do sinal de entrada
        saida = ruido(i);
    end
end
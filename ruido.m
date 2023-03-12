function saida = ruido(entrada, type, num_bits_codif, M,i)
    if(type == 1)
        saida = entrada(i) *complex(randn(1, num_bits_codif/M), randn(1, num_bits_codif/M))*sqrt(0.5);
    end
    if(type == 2)  %Ruido Gaussiano Branco 
        ruido = awgn(entrada, 2, -5); %sinal de entrada, relação sinal-ruído e potência do sinal de entrada
        saida = ruido(i);
    end
end
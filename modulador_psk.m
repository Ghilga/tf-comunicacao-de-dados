% M: quantidade de bits por simbolo
% entrada: vetor de bits de entrada
function saida = modulador_psk(entrada, M)
    tamanho = size(entrada, 2);
    entrada_redimensionada = reshape(entrada,tamanho/M, M);
    entrada_inteiros = bi2de(entrada_redimensionada, 'left-msb');
    entrada_modulada = pskmod(entrada_inteiros, 2^M);
    saida = reshape(entrada_modulada, 1, length(entrada_modulada));
end
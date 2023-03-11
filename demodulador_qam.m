% entrada_modulada: Sinal de entrada modulado em QAM
% saida: Sinal demodulado em QAM (em numeros reais)
function saida = demodulador_qam(entrada_modulada, M)
    saida = qamdemod(entrada_modulada, 2^M);
end
% entrada_modulada: Sinal de entrada modulado em PSK
% saida: Sinal demodulado em PSK (em numeros reais)
function saida = demodulador_psk(entrada_modulada, M)
    saida = pskdemod(entrada_modulada, 2^M);
end
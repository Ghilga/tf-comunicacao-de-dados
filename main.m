clear;
close all;

num_b = 1000000; %n�mero de bits a serem simulados
M = 4; % quantidade de bits por simbolo (utilizado para definir a dimens�o da modula��o)
entrada = fonte(num_b);
trellis = criar_trellis(2,2,3);
entrada_codificada = codificador(entrada, trellis); % codificador convolucional (2,2,3)
entrada_modulada = modulador_qam(entrada_codificada, M); %16-QAM basico, sem codifica��o
num_bits_codif = length(entrada_codificada);
Eb = 10/4;
calcular_ber(entrada, entrada_modulada, trellis, num_b, num_bits_codif, M, Eb);
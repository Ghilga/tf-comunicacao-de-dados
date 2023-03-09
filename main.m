clear;
close all;

entrada = fonte(16)
%codificador(1)
entrada_modulada = modulador_qam(entrada, 4) %16-QAM basico, sem codificação
%ruido(1)
%demodulador(1)
%decodificador(1)
%receptor(1)
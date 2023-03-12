% entrada: numero de bits a serem simulados
% entrada_modulada: entrada modulada
% trellis: estrutura trellis criada na codificacao
% num_b: numero de bits da entrada pura
% num_bits_codif: numero de bits da entrada codificada
% M: quantidade de bits por simbolo
% Eb: energia por bit para a modulacao BPSK utilizada
% ber: bit error rate calculado para cada iteracao
function ber = calcular_ber_sem_cod(entrada, entrada_modulada, num_b, M, Eb, Eb_N0_dB)
    Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
    ber = zeros(size(Eb_N0_lin)); %pre-alocacao do vetor de BER
    
    NP = Eb ./ (Eb_N0_lin); %vetor de potencias do ruido
    NA = sqrt(NP); %vetor de amplitudes do ruido
    
    for i = 1:length(Eb_N0_lin)
        n = ruido(NA, 1, num_b, M, i); %vetor de ru�do complexo com desvio padr�o igual a uma posi��o do vetor NA
        r = entrada_modulada + n; % vetor recebido
        demod = demodulador_qam(r, M); % recupera a informacao (sinal demodulado)
        saida_demodulada = reshape(de2bi(demod, 'left-msb'), 1, num_b); % converte a saida demodulada para bits
        ber(i) = sum(entrada ~= saida_demodulada) / num_b; % contagem de erros e calculo do BER
    end
end
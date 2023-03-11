% entrada: numero de bits a serem simulados
% entrada_modulada: entrada modulada
% trellis: estrutura trellis criada na codificacao
% num_b: numero de bits da entrada pura
% num_bits_codif: numero de bits da entrada codificada
% M: quantidade de bits por simbolo
% Eb: energia por bit para a modulacao BPSK utilizada
% ber: bit error rate calculado para cada iteracao
function ber = calcular_ber(entrada, entrada_modulada, trellis, num_b, num_bits_codif, M, Eb)
    Eb_N0_dB = -2:1:12; %faixa de Eb/N0
    Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
    ber = zeros(size(Eb_N0_lin)); %pre-alocacao do vetor de BER
    
    NP = Eb ./ (Eb_N0_lin); %vetor de potencias do ruido
    NA = sqrt(NP); %vetor de amplitudes do ruido
    
    for i = 1:length(Eb_N0_lin)
        n = NA(i)*complex(randn(1, num_bits_codif/M), randn(1, num_bits_codif/M))*sqrt(0.5); %vetor de ru�do complexo com desvio padr�o igual a uma posi��o do vetor NA
        r = entrada_modulada + n; % vetor recebido
        demod = demodulador_qam(r, M); % recupera a informacao (sinal demodulado)
        saida_demodulada = reshape(de2bi(demod, 'left-msb'), 1, num_bits_codif); % converte a saida demodulada para bits
        saida_decodificada = decodificador(saida_demodulada, trellis, num_b); % decodifica a entrada demodulada
        ber(i) = sum(entrada ~= saida_decodificada) / num_b; % contagem de erros e calculo do BER
    end
    
    ber_theoretical = 0.5*erfc(sqrt(2*Eb_N0_lin)/sqrt(2)); %BER teorico para comparacao
    figure;
    semilogy(Eb_N0_dB, ber, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
    xlabel('Eb/N0 (dB)');
    ylabel('BER');
    legend('Simulado','Te�rico');
end
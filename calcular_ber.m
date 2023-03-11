% entrada: numero de bits a serem simulados
% entrada_modulada: entrada modulada
% trellis: estrutura trellis criada na codificacao
% num_b: numero de bits da entrada pura
% num_bits_codif: numero de bits da entrada codificada
% M: quantidade de bits por simbolo
% Eb: energia por bit para a modulação BPSK utilizada
% ber: bit error rate calculado para cada iteração
function ber = calcular_ber(entrada, entrada_modulada, trellis, num_b, num_bits_codif, M, Eb)
    Eb_N0_dB = -2:1:12; %faixa de Eb/N0
    Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
    ber = zeros(size(Eb_N0_lin)); %pré-alocação do vetor de BER
    
    NP = Eb ./ (Eb_N0_lin); %vetor de potências do ruído
    NA = sqrt(NP); %vetor de amplitudes do ruído
    
    for i = 1:length(Eb_N0_lin)
        n = NA(i)*complex(randn(1, num_bits_codif/M), randn(1, num_bits_codif/M))*sqrt(0.5); %vetor de ruído complexo com desvio padrão igual a uma posição do vetor NA
        r = entrada_modulada + n; % vetor recebido
        demod = demodulador_qam(r, M); % recupera a informação (sinal demodulado)
        saida_demodulada = reshape(de2bi(demod, 'left-msb'), 1, num_bits_codif); % converte a saida demodulada para bits
        saida_decodificada = decodificador(saida_demodulada, trellis, num_b);
        ber(i) = sum(entrada ~= saida_decodificada) / num_b; % contagem de erros e cálculo do BER
    end
    
    ber_theoretical = 0.5*erfc(sqrt(2*Eb_N0_lin)/sqrt(2)); %BER teórico para comparação
    figure;
    semilogy(Eb_N0_dB, ber, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
    xlabel('Eb/N0 (dB)');
    ylabel('BER');
    legend('Simulado','Teórico');
end
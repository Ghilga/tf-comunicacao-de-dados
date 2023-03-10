clear;
close all;

num_b = 1000000; %número de bits a serem simulados
M = 4; % quantidade de bits por simbolo (utilizado para definir a dimensão da modulação)
entrada = fonte(num_b);
%codificador(1)
entrada_modulada = modulador_qam(entrada, M); %16-QAM basico, sem codificação
Eb_N0_dB = -2:1:12; %faixa de Eb/N0
Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
ber = zeros(size(Eb_N0_lin)); %pré-alocação do vetor de BER
Eb = 10/4; % energia por bit para a modulação BPSK utilizada

NP = Eb ./ (Eb_N0_lin); %vetor de potências do ruído
NA = sqrt(NP); %vetor de amplitudes do ruído
    
for i = 1:length(Eb_N0_lin)
    n = NA(i)*complex(randn(1, num_b/M), randn(1, num_b/M))*sqrt(0.5); %vetor de ruído complexo com desvio padrão igual a uma posição do vetor NA
    r = entrada_modulada + n; % vetor recebido
    demod = demodulador_qam(r, M); % recupera a informação (sinal da parte real)
    saida = reshape(de2bi(demod, 'left-msb'), 1, num_b);
    ber(i) = sum(entrada ~= saida) / num_b % contagem de erros e cálculo do BER
end

ber_theoretical = 0.5*erfc(sqrt(2*Eb_N0_lin)/sqrt(2)); %BER teórico para comparação
semilogy(Eb_N0_dB, ber, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('Eb/N0 (dB)');
ylabel('BER');
legend('Simulado','Teórico');

%ruido(1)
% entrada_demodulada = demodulador_qam(entrada_modulada, 4);
% % transforma de volta em um vetor de 1 linha
% saida = reshape(de2bi(entrada_demodulada, 'left-msb'), 1, num_b);
% isequal(entrada, saida)
%decodificador(1)
%receptor(1)



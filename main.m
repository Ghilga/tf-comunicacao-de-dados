clear;
close all;

num_b = 1000000; %número de bits a serem simulados
M = 4; % quantidade de bits por simbolo (utilizado para definir a dimensão da modulação)
entrada = fonte(num_b);
Eb = 10/4; % energia por bit para o 16-QAM
Eb_N0_dB = -4:1:12; %faixa de Eb/N0
Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada

% 16-QAM com codigo (2,2,3)
trellis = criar_trellis(2,2,3);
entrada_codificada = codificador(entrada, trellis); % codificador convolucional
entrada_modulada = modulador_qam(entrada_codificada, M);
num_bits_codif = length(entrada_codificada); % numero de bits no sinal codificado
ber_qam_cod1 = calcular_ber(entrada, entrada_modulada, trellis, num_b, num_bits_codif, M, Eb, Eb_N0_dB);

% 16-QAM com codigo ---
% trellis = criar_trellis(---);
% entrada_codificada = codificador(entrada, trellis); % codificador convolucional
% entrada_modulada = modulador_qam(entrada_codificada, M);
% num_bits_codif = length(entrada_codificada); % numero de bits no sinal codificado
% ber_qam_cod1 = calcular_ber(entrada, entrada_modulada, trellis, num_b, num_bits_codif, M, Eb, Eb_N0_dB);

% 16-QAM com codigo ---
% trellis = criar_trellis(---);
% entrada_codificada = codificador(entrada, trellis); % codificador convolucional
% entrada_modulada = modulador_qam(entrada_codificada, M);
% num_bits_codif = length(entrada_codificada); % numero de bits no sinal codificado
% ber_qam_cod1 = calcular_ber(entrada, entrada_modulada, trellis, num_b, num_bits_codif, M, Eb, Eb_N0_dB);

% 16-QAM sem codigo
entrada_modulada = modulador_qam(entrada, M);
ber_qam_sem_cod = calcular_ber_sem_cod(entrada, entrada_modulada, num_b, M, Eb, Eb_N0_dB);


% Plot dos graficos QAM
ber_theoretical = 0.5*erfc(sqrt(2*Eb_N0_lin)/sqrt(2)); %BER teorico para comparacao
figure;
semilogy(Eb_N0_dB, ber_qam_cod1, 'x', Eb_N0_dB, ber_qam_sem_cod, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('Eb/N0 (dB)');
ylabel('BER');
legend('QAM(2,2,3)','QAM(sem cod)','Teorico');
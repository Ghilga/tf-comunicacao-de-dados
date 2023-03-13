clear;
close all;

num_b = 1000000; %número de bits a serem simulados
entrada = fonte(num_b);
M_QAM = 4; % quantidade de bits por simbolo QAM (utilizado para definir a dimensão da modulação)
M_PSK = 2; % quantidade de bits por simbolo PSK
Eb_QAM = 10/4; % energia por bit para o 16-QAM
Eb_PSK = 1; % energia por bit para o 32-PSK
Eb_N0_dB = -2:1:12; %faixa de Eb/N0
Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada

% Inicializar a treliçaa para cada codificação.
% Aqui sao definidos os 3 codigos convolucionais a serem usados na
% simulação
trellis(1) = criar_trellis(2,2,3);
trellis(2) = criar_trellis(5,25,37);
trellis(3) = criar_trellis(7,131,177);

% Criar as entradas codificadas para cada codigo convolucional
entrada_codificada = cell(1,3);
for i = 1:3
    entrada_codificada{i} = codificador(entrada, trellis(i));
end

% Calcular os BER para cada codigo usando QAM
ber_qam_cod = cell(1,3);
for i = 1:3
    entrada_modulada = modulador_qam(entrada_codificada{i}, M_QAM);
    num_bits_codif = length(entrada_codificada{i}); % numero de bits no sinal codificado
    ber_qam_cod{i} = calcular_ber(entrada, entrada_modulada, trellis(i), num_b, num_bits_codif, M_QAM, Eb_QAM, Eb_N0_dB, 'qam');
end

% 16-QAM sem codigo
entrada_modulada = modulador_qam(entrada, M_QAM);
ber_qam_sem_cod = calcular_ber_sem_cod(entrada, entrada_modulada, num_b, M_QAM, Eb_QAM, Eb_N0_dB, 'qam');

% -------------------------------//----------------------------//-------------------------

% Calcular os BER para cada codigo usando PSK
ber_psk_cod = cell(1,3);
for i = 1:3
    entrada_modulada = modulador_psk(entrada_codificada{i}, M_PSK);
    num_bits_codif = length(entrada_codificada{i}); % numero de bits no sinal codificado
    ber_psk_cod{i} = calcular_ber(entrada, entrada_modulada, trellis(i), num_b, num_bits_codif, M_PSK, Eb_PSK, Eb_N0_dB, 'psk');
end

% M-PSK sem codigo
entrada_modulada = modulador_psk(entrada, M_PSK);
ber_psk_sem_cod = calcular_ber_sem_cod(entrada, entrada_modulada, num_b, M_PSK, Eb_PSK, Eb_N0_dB, 'psk');

% Colocar todos os BER da modulacao QAM em uma matriz para plotar mais facilmente
ber_qam = vertcat(ber_qam_cod{1}, ber_qam_cod{2}, ber_qam_cod{3}, ber_qam_sem_cod); 
% Colocar todos os BER da modulacao PSK em uma matriz para plotar mais facilmente
ber_psk = vertcat(ber_psk_cod{1}, ber_psk_cod{2}, ber_psk_cod{3}, ber_psk_sem_cod); 

ber_theoretical = 0.5*erfc(sqrt(2*Eb_N0_lin)/sqrt(2)); %BER teorico para comparacao

% Plot dos graficos QAM
figure;
% semilogy(Eb_N0_dB, ber_qam_cod{1}, 'x', Eb_N0_dB, ber_qam_cod{2}, 'x', Eb_N0_dB, ber_qam_cod{3}, 'x', Eb_N0_dB, ber_qam_sem_cod, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
semilogy(Eb_N0_dB, ber_qam, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('Eb/N0 (dB)');
ylabel('BER');
legend('QAM(2,2,3)','QAM(5,25,37)','QAM(7,131,177)','QAM(sem cod)','Teorico');

% Plot dos graficos PSK
figure;
semilogy(Eb_N0_dB, ber_psk, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('Eb/N0 (dB)');
ylabel('BER');
legend('PSK(2,2,3)','PSK(5,25,37)','PSK(7,131,177)','PSK(sem cod)','Teorico');




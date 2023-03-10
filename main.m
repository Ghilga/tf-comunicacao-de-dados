clear;
close all;

num_b = 1000000; %n�mero de bits a serem simulados
M = 4; % quantidade de bits por simbolo (utilizado para definir a dimens�o da modula��o)
entrada = fonte(num_b);
%codificador(1)
entrada_modulada = modulador_qam(entrada, M); %16-QAM basico, sem codifica��o
Eb_N0_dB = -2:1:12; %faixa de Eb/N0
Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
ber = zeros(size(Eb_N0_lin)); %pr�-aloca��o do vetor de BER
Eb = 10/4; % energia por bit para a modula��o BPSK utilizada

NP = Eb ./ (Eb_N0_lin); %vetor de pot�ncias do ru�do
NA = sqrt(NP); %vetor de amplitudes do ru�do
    
for i = 1:length(Eb_N0_lin)
    n = NA(i)*complex(randn(1, num_b/M), randn(1, num_b/M))*sqrt(0.5); %vetor de ru�do complexo com desvio padr�o igual a uma posi��o do vetor NA
    r = entrada_modulada + n; % vetor recebido
    demod = demodulador_qam(r, M); % recupera a informa��o (sinal da parte real)
    saida = reshape(de2bi(demod, 'left-msb'), 1, num_b);
    ber(i) = sum(entrada ~= saida) / num_b % contagem de erros e c�lculo do BER
end

ber_theoretical = 0.5*erfc(sqrt(2*Eb_N0_lin)/sqrt(2)); %BER te�rico para compara��o
semilogy(Eb_N0_dB, ber, 'x', Eb_N0_dB, ber_theoretical, 'r', 'LineWidth', 2, 'MarkerSize', 10);
xlabel('Eb/N0 (dB)');
ylabel('BER');
legend('Simulado','Te�rico');

%ruido(1)
% entrada_demodulada = demodulador_qam(entrada_modulada, 4);
% % transforma de volta em um vetor de 1 linha
% saida = reshape(de2bi(entrada_demodulada, 'left-msb'), 1, num_b);
% isequal(entrada, saida)
%decodificador(1)
%receptor(1)



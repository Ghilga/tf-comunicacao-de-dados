% entrada: Entrada de bits demodulada
% trellis: Estrutura trellis criada na codificacao
% num_bits: Tamanho da entrada
function saida = decodificador(entrada, trellis, num_bits)
    saida = vitdec(entrada, trellis, num_bits, 'trunc', 'hard');
end
% K: Comprimento limitante (da estrutura trellis)
% k: Numero de bits de entrada (da estrutura trellis)
% n: Numero de bits de saida (da estrutura trellis)
function saida = criar_trellis(K, k, n)
    saida =  poly2trellis(K,[k n]);
end
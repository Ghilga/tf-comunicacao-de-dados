% entrada: Entrada de bits pura
% n: numeros de bits em xor, e saida
function saida = convolucionais(entrada, n)
    k = zeros(1,n);
    k_at = zeros(1,n);
    conv = [];
    for i = 1:length(entrada)
        for p = 1:length(k)
            conv(end+1) = xor(entrada(i), k(p));
            if p<n
                k_at(p+1) = k(p);
            end
        end
        k = k_at;
        k(1) = entrada(i);
        
    end
    saida = conv;
end


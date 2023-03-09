# tf-comunicacao-de-dados

Fonte e Receptor de informação
 - fonte é a mensagem de entrada, ou então o sistema que faz o envio das mensagens iniciais
    - Geramos um vetor de bits (0 e 1) 
 - receptor apenas verifica se o que foi recebido é correto

codificador de canal
 - o que é: É uma codificação nos bits de entrada para poder fazer a detecção e correção de erros
 - como fazer: Acho que dá pra utilizar as codificações que ja existem no proprio matlab
 - 3 codigos convolucionais e 1 vez sem codigo nenhum 
    - a decidir
	
2 modulações
 - quais? QAM e PSK 
 - 1 modulação para os 3 + 1 codigos e depois outra para os mesmos codigos (os códigos de convolução que são feitos pelo codificador de canal)
	
Acredito que após a modulação (e a introdução de ruídos) que é feito os calculos de Eb/N0, que são mencionados na especificação do trabalho (ainda precisamos entender melhor essa parte)

	
como fazer o ruido

como decodificar
 - A princípio é so utilizar as funções da biblioteca também

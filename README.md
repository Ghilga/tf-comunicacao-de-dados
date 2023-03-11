# tf-comunicacao-de-dados

Fonte e Receptor de informação
 - Fonte é a mensagem de entrada, ou então o sistema que faz o envio das mensagens iniciais
    - Geramos um vetor de bits (0 e 1) 
 - Receptor apenas verifica se o que foi recebido é correto

codificador de canal
 - O que é: É uma codificação nos bits de entrada para poder fazer a detecção e correção de erros
 - Como fazer: Acho que dá pra utilizar as codificações que ja existem no proprio matlab
 - 3 codigos **convolucionais** e 1 vez sem codigo nenhum 
    - a decidir
	
2 modulações
 - quais? QAM e PSK 
 - 1 modulação para os 3 + 1 codigos e depois outra para os mesmos codigos (os códigos de convolução que são feitos pelo codificador de canal)

Após a modulação nós fazemos o calculo do BER, e durante esse calculo fazemos a demodulação e decodificação
 - O ruído é introduzido durante o calculo do BER

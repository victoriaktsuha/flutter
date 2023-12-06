# Flutter/Dart notes

Notes gathered througth different courses and sources

## Dart 

- 2010
    - Created by Google to replace JS
    - Perform with higher speed
    - More secure
    - Easy learning

- Used in:
    - Mobile
    - Web
    - Server

## Flutter

### What it is ? 
- SDK (Software Development Kit) used to create apps for Android and iOS
- Open source created by Google

### Dart + Flutter

- Using Flutter SDK, we'll write codes for apps in Dart Programm Language
- When this code is excuted, it's generated (or compiled to) a Java code for Android plataforms and Swift code for iOS platforms in the same project.


## Variável

Área de memória associada a um nome, que pode armazenar valores de um determinado tipo.<br>
Ex.: a = 1

*let* para mutável e *const* para imutável - *var* pode ser utilizado para valores mutáveis, mas torna o valor global, podendo ser acessado de forma externa e não sendo muito seguro.<br>

let nome = 'nome';
const pi = 3.14;

### Tipos de variáveis

- *var*: tipo de variavel genérico (número, string, booleano); Ex.: var nome = 'nome'

- *String*: A palavra reservada **String** antes do nome da variável define o tipo de valor que ela deverá receber. No caso, apenas **textos**, entre "" ou ''; Ex.: String id = '123'

- *int*: A palavra reservada **int** antes do nome da variável define o tipo de valor que ela deverá receber. No caso, apenas **números inteiros**, SEM "" ou ''; Ex.: int id = 123

- *double*: A palavra reservada **double** antes do nome da variável define o tipo de valor que ela deverá receber. No caso, apenas **números decimais**, SEM "" ou ''; Ex.: double price = 19.99

- *bool*: A palavra reservada **bool** antes do nome da variável define o tipo de valor que ela deverá receber. No caso, apenas **booleanos**, SEM "" ou '', apenas TRUE ou FALSE; Ex.: bool access = false
<br>

## Arrays

É uma maneira de armazenar mais valores em uma mesma variável. <br>Ex.: let nomes = ['João', 'Maria', 'José'];

Os valores são acessíveis pelo seus índices, começando pelo 0. <br>Ex.: O índice de João é 0, o de Maria é 1, o de José é 2 ...

Pode-se também atribuir novos valores aos índices, caso a variável não seja uma constante<br>
Ex.: nomes[1] = 'Mateus';
<br>

## Operadores aritméticos

- Soma (+)
- Subtração (-)
- Divisão (/)
- Multiplicação (*)
- Incremento (++)
- Incremento + 1 (+=)
- Decremento (--)
- Decremento - 1(-=)
<br>

## Operadores relacionais
Utilizado para testes/comparação

- == (Igual)
- != (Diferente)
- '>' (Maior que)
- < (Menor que)
- '>=' (Maior ou igual)
- <= (Menor ou igual)
<br>

## Controle de fluxo - if else

- if (condição satisfeita)
- else (exceção)

        if(confdicao 1){
            print("True")
        }else if(condicao 2){
            print("True")
        }else{
            print("False")
        }
<br>

## Controle de fluxo - switch

Similar ao if/else

    switch(valor){
        case "true" : 
            print("true");
            break;
        case "false" :
            print("false");
            break;
        case "1" :
            print("number");
            break;
        case "name" :
            print("string");
            break;
        default :
            print("None of options");
    }
<br>  

## Loops - for & while

Utilizado para exibições e listagem de itens

**while**<br>Enquanto a condição for satisfeita, a instrução será executada. 

Ex.: Listar números até 4

    final int numero = 5;
    while(numero >= 4){
        print(numero);
    }

**for**<br>Recebe como argumento todos os parametros para serem executados até que a condição não seja mais satisfeita.

Ex.: Listar números até 10

    for(int i = 0; i <= 10; i++){
        print(i);
    }

Ex.: Exibir postagens

    final postagens = <String>[
      "Viagem à Acapulco",
      "Vendo churros. Chamar inbox",
      "Festa na vila !"
    ];

    for(String post in postagens){
        print("Post: $post");
    }

**do while**<br>Primeiro executa para depois testar se a condição foi satisfeita, garantindo que pelo menos 1 vez o código de instrução será executado.

    int numero = 0;
    do{
        print(numero);
        numero++;
    }while(numero <= 5);
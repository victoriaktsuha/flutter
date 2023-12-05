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

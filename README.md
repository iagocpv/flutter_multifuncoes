
# App Multifunções Flutter

Este é um aplicativo Flutter com várias funcionalidades em diferentes telas:

- Conversor de temperatura (Celsius para Fahrenheit)
- Calculadora de média
- Calculadora de desconto para uma lista de produtos
- Calculadora da área de um retângulo
- Jogo de adivinhação de números (1 a 10)

---

## Como rodar o projeto

1. Certifique-se de ter o Flutter instalado:  
   [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

2. Clone este repositório:

   ```bash
   git clone https://github.com/iagocpv/flutter_multifuncoes.git
   cd flutter_multifuncoes
   ```

3. Instale as dependências:

   ```bash
   flutter pub get
   ```

4. Rode o app no emulador ou dispositivo conectado:

   ```bash
   flutter run
   ```

---

## Estrutura do projeto

- `lib/main.dart`: arquivo principal que inicializa o app e define as rotas.
- `lib/routes/app_routes.dart`: gerencia as rotas do aplicativo.
- `lib/screens/`: pasta com as telas (conversor, média, desconto, área, adivinhação).
- Cada tela é um Widget que implementa sua funcionalidade específica.

---

## Funcionalidades

### Conversor °C para °F

Permite converter uma temperatura em Celsius para Fahrenheit.

### Calculadora de Média

Calcula a média entre números fornecidos pelo usuário.

### Calculadora de Desconto

Exibe uma lista de produtos e calcula o preço final aplicando descontos.

### Calculadora de Área do Retângulo

Calcula a área de um retângulo baseado na largura e altura fornecidas.

### Jogo de Adivinhação

O computador pensa em um número entre 1 e 10, e o usuário tenta adivinhar em até 5 tentativas. O app informa se o palpite está muito alto, muito baixo ou correto.


---

## Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para detalhes.

# Sistema de Vendas - Testes Automatizados

Este repositório contém os **cenários de teste automatizados** para o sistema de vendas [SauceDemo](https://www.saucedemo.com/), utilizando **Robot Framework** com as bibliotecas **Browser**, **FakerLibrary** e **String**.

---

## Tecnologias utilizadas

- **Robot Framework**: Framework de automação de testes.
- **Browser Library**: Para automação de navegação e interação com o navegador.
- **FakerLibrary**: Para geração de dados fictícios (nome, sobrenome, CEP).
- **String Library**: Para manipulação de strings.
- **Navegador utilizado**: Chromium.

---

## Estrutura do projeto

- **Settings**: Define bibliotecas e documentação dos testes.
- **Variables**: Contém URL da aplicação e senha padrão para login.
- **Keywords**: Palavras-chave personalizadas para simplificar e reaproveitar ações.
- **Test Cases**: Cenários de teste definidos para diferentes usuários e fluxos.

---

## Keywords principais

- `Abrir_Aplicacao`: Abre o navegador e acessa a aplicação.
- `Login [usuario]`: Realiza login com o usuário fornecido e senha padrão.
- `Validar_E_Adicionar_Produto [nome_produto] [preco_produto] [add_btn]`: Valida nome e preço do produto e adiciona ao carrinho.
- `Remover_Produto [remove_btn]`: Remove um produto do carrinho.
- `Acessar_Carrinho`: Acessa o carrinho de compras.
- `Validar_Produto_No_Carrinho [nome_produto]`: Valida se o produto está no carrinho.
- `Finalizar_Compra [nome] [sobrenome] [cep]`: Realiza o fluxo de checkout e finaliza a compra.
- `Gerar_Dados_Fake`: Gera nome, sobrenome e CEP aleatórios.

---

## Cenários de teste

### 1. Compra com adição e remoção de produtos (usuário `standard_user`)

- Login com usuário `standard_user`.
- Adiciona dois produtos ao carrinho:
  - Sauce Labs Bike Light
  - Sauce Labs Fleece Jacket
- Remove o primeiro produto adicionado.
- Acessa o carrinho e valida que apenas o segundo produto permanece.
- Finaliza a compra utilizando dados fictícios.

---

### 2. Compra com adição e remoção de produtos (usuário `performance_glitch_user`)

- Login com usuário `performance_glitch_user`.
- Adiciona dois produtos ao carrinho:
  - Sauce Labs Bike Light
  - Sauce Labs Fleece Jacket
- Remove o primeiro produto adicionado.
- Acessa o carrinho e valida que apenas o segundo produto permanece.
- Finaliza a compra utilizando dados fictícios.

---

### 3. Finalização de compra sem adicionar produtos (usuário `standard_user`)

- Login com usuário `standard_user`.
- Acessa o carrinho diretamente sem adicionar produtos.
- Preenche os dados fictícios e tenta finalizar a compra.

---

## Como executar os testes

1. Instalar dependências:

```bash
pip install robotframework
pip install robotframework-browser
pip install robotframework-fakerlibrary

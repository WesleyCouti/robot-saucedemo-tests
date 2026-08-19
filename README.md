# Robot Framework E2E Automation

End-to-end test automation project built with **Robot Framework** and **Browser Library** against the SauceDemo web application.

The project covers purchase and checkout flows, reusable keywords, test data generation, test organization by domain, execution by tags and automated test execution with **GitHub Actions**.

## Project Goals

This project was created to demonstrate a structured approach to web test automation using Robot Framework, including:

- E2E test automation
- reusable keywords
- separation of test cases and resources
- smoke and regression testing
- negative scenarios
- dynamic test data
- headless browser execution
- CI/CD integration
- automated report generation

## Tech Stack

- Robot Framework
- Robot Framework Browser
- Playwright / Chromium
- FakerLibrary
- Python
- GitHub Actions

## Project Structure

```text
robot-saucedemo-tests/
├── .github/
│   └── workflows/
│       └── robot.yml
├── resources/
│   ├── common_keywords.robot
│   ├── cart_keywords.robot
│   ├── checkout_keywords.robot
│   └── variables.robot
├── tests/
│   ├── cart.robot
│   └── checkout.robot
├── .gitignore
├── README.md
└── requirements.txt
```

### resources

Reusable components used by the test suites.

- `common_keywords.robot` — browser setup, login and test data generation.
- `cart_keywords.robot` — product and shopping cart interactions.
- `checkout_keywords.robot` — checkout actions and validations.
- `variables.robot` — shared configuration such as application URL, browser and execution mode.

### tests

Test cases organized by business domain.

- `cart.robot` — purchase and cart scenarios.
- `checkout.robot` — checkout validation scenarios.

## Automated Scenarios

### Standard User Purchase

Validates the main purchase flow using `standard_user`.

The scenario:

1. logs into SauceDemo;
2. validates product name and price;
3. adds products to the cart;
4. removes one product;
5. validates the remaining product;
6. completes the checkout using dynamically generated customer data;
7. validates the successful purchase message.

Tags:

```text
smoke
regression
```

### Performance Glitch User Purchase

Executes the purchase flow using `performance_glitch_user`.

The scenario validates that the application flow continues working correctly for this user profile.

Tag:

```text
regression
```

### Checkout Required Fields Validation

Negative scenario that attempts to continue checkout without filling the required customer information.

The test validates the expected validation message:

```text
Error: First Name is required
```

Tags:

```text
negative
regression
```

## Reusable Keywords

The automation uses custom keywords to keep test cases readable and avoid duplicated implementation.

Examples:

```text
Abrir Aplicacao
Fechar Aplicacao
Login
Validar E Adicionar Produto
Remover Produto
Acessar Carrinho
Validar Produto No Carrinho
Preencher Dados Do Checkout
Finalizar Compra
Validar Erro No Checkout
Gerar Dados Fake
```

The test cases describe the business flow while implementation details remain inside the resource files.

## Test Data

Customer information used during checkout is generated dynamically with FakerLibrary.

Generated data includes:

- first name;
- last name;
- postal code.

This avoids using fixed customer information across executions.

## Running Locally

### Requirements

- Python 3
- Node.js
- Robot Framework Browser dependencies

Install the project dependencies:

```bash
pip install -r requirements.txt
```

Initialize Robot Framework Browser:

```bash
rfbrowser init
```

Run all tests:

```bash
robot --outputdir results tests/
```

## Running Tests by Tag

Run the smoke suite:

```bash
robot --include smoke --outputdir results tests/
```

Run the regression suite:

```bash
robot --include regression --outputdir results tests/
```

Run negative scenarios:

```bash
robot --include negative --outputdir results tests/
```

## CI/CD

The project uses **GitHub Actions** to execute the automated tests.

The pipeline is triggered on:

- pushes to `master`;
- pull requests targeting `master`;
- manual execution through GitHub Actions.

The workflow executes three independent test suites:

```text
Smoke Suite
Regression Suite
Negative Suite
```

Each suite:

1. checks out the repository;
2. configures Python;
3. installs the project dependencies;
4. initializes Robot Framework Browser;
5. executes the corresponding test tag;
6. generates Robot Framework reports;
7. uploads the execution results as GitHub Actions artifacts.

A failure in an automated test causes the corresponding CI job to fail.

## Test Reports

Robot Framework generates:

```text
output.xml
log.html
report.html
```

The reports are generated during the CI execution and uploaded as GitHub Actions artifacts.

Generated reports are not versioned in the repository.

## Current Test Coverage

| Suite | Coverage |
|---|---|
| Smoke | Main purchase flow |
| Regression | Purchase and checkout scenarios |
| Negative | Required checkout field validation |
| E2E | Login → product → cart → checkout |

## Automation Approach

The project separates test responsibilities into three main layers:

```text
Tests
  ↓
Reusable Keywords
  ↓
Browser Interactions
```

Test cases focus on business scenarios while reusable keywords handle browser interactions and validations.

This structure makes the suite easier to maintain and allows new scenarios to reuse existing automation components.

## Skills Demonstrated

`Robot Framework` `Browser Library` `Playwright` `Python` `E2E Testing` `Test Automation` `Smoke Testing` `Regression Testing` `Negative Testing` `Test Data Generation` `GitHub Actions` `CI/CD`

## Application Under Test

The automation uses the public SauceDemo application:

https://www.saucedemo.com/

The application is used exclusively as a demonstration environment for test automation practice.

## Author

**Wesley Coutinho**  
QA Engineer | Test Automation

LinkedIn: https://www.linkedin.com/in/wesleycoutinhoqa/  
GitHub: https://github.com/WesleyCouti

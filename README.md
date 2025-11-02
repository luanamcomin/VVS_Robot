# Projeto de Automação de Testes – OrangeHRM (Robot Framework)

Automação web do site de demonstração do OrangeHRM: https://opensource-demo.orangehrmlive.com/web/index.php/auth/login

Este projeto usa Robot Framework com SeleniumLibrary para validar fluxos principais do sistema:
- Login com credenciais válidas
- Acesso ao Dashboard
- Adição de funcionário
- Busca de funcionário
- Logout
- Fluxo ponta a ponta (E2E) integrando tudo acima

## Estrutura de Pastas
```
Robot-Senac/
├─ resources/
│  └─ keywords.robot             # Palavras‑chave (keywords) reutilizáveis
├─ tests/
│  ├─ login_tests.robot          # Login
│  ├─ dashboar_tests.robot       # Verificação de Dashboard
│  ├─ add_employee_tests.robot   # Adição de funcionário
│  ├─ search_employee_tests.robot# Busca de funcionário
│  ├─ logout_tests.robot         # Logout
│  └─ e2e_tests.robot            # Fluxo ponta a ponta
├─ variables/
│  └─ variables.robot            # Variáveis globais (URL, navegador, usuário, senha, velocidade)
└─ results/                      # Relatórios e evidências (screenshots)
```

## Requisitos
- Windows com Python 3 instalado (3.8+ recomendado)
- Google Chrome instalado
- ChromeDriver compatível com a versão do seu Chrome disponível no PATH
- Pacotes Python:
  - robotframework
  - robotframework-seleniumlibrary

## Instalação
1) (Opcional) Criar e ativar um ambiente virtual
```
python -m venv .venv
.\.venv\Scripts\activate
```

2) Instalar dependências
```
pip install robotframework==6.1.1
pip install robotframework-seleniumlibrary==6.2.0
```

3) Configurar o ChromeDriver
- Baixe a versão que corresponde ao seu Chrome:
  - https://googlechromelabs.github.io/chrome-for-testing/#stable
- Extraia e coloque o executável no PATH (ex.: C:\Tools\chrome-driver\ e adicione ao PATH do sistema).
- Valide no terminal:
```
chromedriver --version
```

Dica: Se preferir gerenciar automaticamente, você pode usar SeleniumManager (Selenium 4.6+) que muitas vezes resolve o driver. Se houver erros, configure manualmente o ChromeDriver no PATH.

## Variáveis Globais
Arquivo `variables/variables.robot`:
- `${URL}`: URL do sistema (demo OrangeHRM)
- `${BROWSER}`: `chrome`
- `${USERNAME}`: `Admin`
- `${PASSWORD}`: `admin123`
- `${SELENIUM_SPEED}`: atraso entre comandos (ex.: `0.6 seconds`)

Você pode sobrescrever variáveis em tempo de execução com `-v`:
```
python -m robot -d results -v SELENIUM_SPEED:"1.0 seconds" tests/
```

## Como Executar (Windows)
No diretório raiz do projeto (`Robot-Senac`):

- Executar todos os testes
```
python -m robot -d results tests/
```

- Executar apenas um arquivo de teste (ex.: login)
```
python -m robot -d results tests/login_tests.robot
```

- Executar o teste ponta a ponta (E2E)
```
python -m robot -d results tests/e2e_tests.robot
```

Relatórios serão gerados em `results/`:
- `report.html`
- `log.html`
- Screenshots de evidências

## Execução mais lenta (para apresentação)
Há duas formas principais:
- Controlada por variável global: ajuste `${SELENIUM_SPEED}` em `variables/variables.robot` (ex.: `1.0 seconds`).
- Override por linha de comando:
```
python -m robot -d results -v SELENIUM_SPEED:"1.0 seconds" tests/e2e_tests.robot
```

Opcionalmente, você pode inserir `Sleep` em pontos desejados do fluxo para pausas adicionais.

## Dicas e Solução de Problemas (Troubleshooting)
- "robot não é reconhecido": use `python -m robot` em vez de `robot` no Windows.
- Erros de driver (SessionNotCreated, etc.): verifique a compatibilidade Chrome x ChromeDriver e o PATH.
- Tempo de carregamento: aumente o timeout padrão no início do teste com `Set Selenium Timeout    10 seconds`.
- Elementos não encontrados: a UI do demo pode variar; ajuste seletores em `resources/keywords.robot`.
- "Suite contains no tests": verifique se seu arquivo `.robot` possui a seção `*** Test Cases ***` e se o nome do caso de teste está logo abaixo sem linhas de formatação inválidas. Evite caracteres extras (por exemplo, um ponto no fim do nome de keyword).

## Comandos úteis
- Executar e abrir o relatório automaticamente (PowerShell):
```
python -m robot -d results tests/; start .\results\report.html
```

## Licença
Projeto acadêmico/demonstrativo usando o ambiente OrangeHRM Demo.

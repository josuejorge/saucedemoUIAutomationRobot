# saucedemoUIAutomationRobot
robot framework UI automation
saucedemoUIAutomationRobot https://www.saucedemo.com/

<img width="889" height="392" alt="image" src="https://github.com/user-attachments/assets/830cedaf-5848-4042-bd4d-7f90e8c71c11" />

<img width="1889" height="902" alt="image" src="https://github.com/user-attachments/assets/dcedbdf5-f6af-4b1a-80da-3d5617e6a510" />

---

## Pré-requisitos

- Python 3.x
- Google Chrome + ChromeDriver compatível no PATH
- Java (para o Allure CLI)
- Node.js / npm (para instalar o Allure CLI)

## Instalação

**1. Dependências Python**
```bash
pip install -r requirements.txt
```

**2. Allure CLI** *(apenas na primeira vez)*
```bash
npm install -g allure-commandline
```

**3. Variáveis de ambiente**

Copie o arquivo de template e preencha com suas credenciais:
```bash
cp variables/variables.template.robot variables/variables.robot
```

## Executando os testes

**Sequencial**
```bash
robot --listener allure_robotframework --listener listeners/evidence_listener.py --outputdir results tests/
```

**Paralelo (recomendado)**
```bash
pabot --processes 4 --listener allure_robotframework --listener listeners/evidence_listener.py --outputdir results tests/
```

## Relatórios

**Allure Report**
```bash
allure generate output\allure -o allure-report --clean
allure open allure-report
```

**Evidências por teste**

Geradas automaticamente na pasta `evidence/` após cada execução.
Cada teste gera um arquivo HTML individual com passo a passo e screenshots.

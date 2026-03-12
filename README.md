SI-PI5-2026-T101-G06

IA para Análise de Seletividade Alimentar em Crianças

### Aplicação em Nutrição, Fonoaudiologia e Psicologia

## Problema

A seletividade alimentar é comum em crianças, especialmente no Transtorno do Espectro Autista (TEA). Profissionais que acompanham essas crianças frequentemente dependem de relatos subjetivos dos pais sobre o que foi consumido nas refeições, o que dificulta a coleta de dados confiáveis para avaliar padrões de aceitação ou rejeição alimentar.

Essa limitação reduz a capacidade de monitorar progresso terapêutico e de estruturar intervenções baseadas em evidências.

---

## Objetivo

Desenvolver um aplicativo que utilize **visão computacional** para identificar alimentos presentes em refeições infantis e estimar a proporção consumida, gerando **métricas objetivas sobre padrões alimentares** para apoiar profissionais de saúde no acompanhamento de crianças com seletividade alimentar.

---

## Funcionamento da Solução

Os pais registram duas imagens da refeição:

1. Antes da criança iniciar a alimentação
2. Após a refeição

Um modelo de **segmentação de instâncias** identifica os alimentos presentes no prato e estima a diferença de volume ou área consumida entre as imagens.

A partir dessas informações, o sistema calcula:

- proporção de alimentos consumidos
- taxa de aceitação por categoria alimentar
- padrões de rejeição

---

## Análises Geradas pela IA

O sistema gera relatórios semanais ou quinzenais com insights clínicos como:

- taxa de aceitação alimentar
- padrões de rejeição por cor, textura ou grupo alimentar
- evolução ao longo do tempo

Exemplo de insight:

> “Nos últimos 14 dias o paciente aceitou 92% de alimentos pastosos e amarelos, mas rejeitou 100% de alimentos verdes com textura crocante.”
> 

Essas informações auxiliam o profissional na construção de **protocolos de exposição alimentar progressiva**.

## Estrutura do Relatório (IA para Nutris/Fonos)

Para que o relatório seja realmente útil para o profissional, a IA pode focar nos seguintes dados extraídos das fotos:

- **Análise de Volume Real:** Comparação volumétrica entre a foto do "antes" e do "depois".
- **Mapeamento de Rejeição por Textura:** Identificar se o que sobrou no prato tem um padrão (ex: alimentos pastosos, crocantes ou fibrosos).
- **Cromatografia Alimentar:** Verificar se a criança aceita melhor cores específicas (muitas crianças com seletividade preferem alimentos "beges" ou amarelados).
- **Linha do Tempo de Interação:** O app registra se a criança apenas tocou no alimento, moveu de lugar ou efetivamente ingeriu, gerando um gráfico de "Curva de Aceitação".

---

## Funcionalidades Adicionais

### Gamificação Positiva

O aplicativo inclui um sistema de reforço positivo para incentivar a interação da criança com novos alimentos.

Exemplos de recompensas:

- selo "Explorador de Texturas"
- selo "Coragem para Provar"
- conquistas desbloqueadas ao experimentar novos alimentos

A clínica ou profissional pode complementar com recompensas físicas alinhadas aos marcos registrados no aplicativo.

---

### Gráfico de Exposição Progressiva

Ferramenta que permite ao profissional acompanhar:

- número de exposições a um alimento específico
- tempo até a aceitação
- evolução da tolerância alimentar

Exemplo:

> acompanhar quantas vezes o brócolis foi apresentado antes da criança aceitar experimentá-lo.
>
# 🚀 Rick and Morty Flutter App

## 📋 Descrição do Projeto

Este projeto foi desenvolvido como parte do **Desafio Kode Start 2025**, demonstrando habilidades avançadas em Flutter com uma arquitetura robusta e escalável. Embora o desafio fosse simples, optei por implementar uma solução mais robusta para demonstrar conhecimento em arquitetura limpa, gerenciamento de estado e boas práticas de desenvolvimento.

## 🎯 Funcionalidades Implementadas

### ✅ Funcionalidades Obrigatórias

- **Listagem de personagens** com scroll infinito
- **Cards com nome e imagem** dos personagens
- **Tela de detalhes** completa com:
  - Nome, imagem, espécie, gênero
  - Status, origem, última localização
  - Primeira aparição (episódios)
- **Navegação** entre lista e detalhes

### 🚀 Funcionalidades Extras

- **Filtro por nome** com busca em tempo real
- **Filtro por status** (Alive, Dead, Unknown, All)
- **Splash Screen** animada com tema da API
- **Tratamento de erros** robusto com animações
- **Shimmers de carregamento** para melhor UX
- **Loadings** durante buscas e navegações
- **Design fiel ao Figma** proposto no desafio
- **Ícone personalizado** do aplicativo em vez do ícone padrão do Flutter

## 🏗️ Arquitetura do Projeto

### 📱 Estrutura de Camadas

O projeto segue a **Arquitetura Limpa (Clean Architecture)** com separação clara de responsabilidades:

```
lib/
├── app/
│   ├── app_module.dart          # Módulo principal da aplicação
│   ├── app_widget.dart          # Widget raiz da aplicação
│   ├── data_layer/              # Camada de Dados
│   ├── domain_layer/            # Camada de Domínio
│   ├── infra/                   # Infraestrutura e Configurações
│   └── presentation_layer/      # Camada de Apresentação
```

### 🔧 Camada de Infraestrutura (`infra/`)

#### Configurações Base

- **`base/`**: Estados base da aplicação
- **`config/`**: Configurações de rede e responsividade
- **`core/`**: Componentes, extensões, rotas e temas

#### Componentes Core

- **`app_bar_component.dart`**: AppBar personalizado
- **`error_view_component.dart`**: Componente de erro com animação
- **`character_status.dart`**: Extensões para status dos personagens
- **`status_filter.dart`**: Lógica de filtros por status

#### Sistema de Temas

- **`app_colors.dart`**: Paleta de cores consistente
- **`app_icons.dart`**: Ícones da aplicação
- **`app_images.dart`**: Imagens e assets
- **`app_lottie.dart`**: Animações Lottie

### 🎯 Camada de Domínio (`domain_layer/`)

#### Entidades

- **`home_character_entity.dart`**: Entidade principal do personagem
- **`home_list_entity.dart`**: Entidade para listas paginadas

#### Casos de Uso

- **`get_home_characters_use_case.dart`**: Busca de personagens
- **`get_home_character_by_id_use_case.dart`**: Busca por ID

#### Repositórios Abstratos

- **`home_repository_interface.dart`**: Contrato do repositório

### 📊 Camada de Dados (`data_layer/`)

#### DTOs (Data Transfer Objects)

- **`home_character_dto.dart`**: Mapeamento da API para entidades
- **`home_list_dto.dart`**: Mapeamento de listas paginadas

#### Fontes de Dados

- **`home_data_source.dart`**: Comunicação direta com a API

#### Repositórios

- **`home_repository.dart`**: Implementação concreta do repositório

### 🎨 Camada de Apresentação (`presentation_layer/`)

#### Módulos

- **`splash/`**: Tela de abertura animada
- **`home/`**: Módulo principal com lista e detalhes

#### Gerenciamento de Estado

- **`cubit/`**: Implementação do BLoC pattern
  - **`home_cubit.dart`**: Lógica de negócio da tela principal
  - **`home_state.dart`**: Estados da aplicação

#### Widgets Especializados

- **`character_card.dart`**: Card do personagem
- **`search_field.dart`**: Campo de busca com validação
- **`status_filter_bar.dart`**: Barra de filtros por status
- **`character_shimmer_list.dart`**: Shimmer de carregamento
- **`movie_detail_shimmer.dart`**: Shimmer da tela de detalhes

## 🎭 Gerenciamento de Estado

### 🧱 BLoC Pattern (flutter_bloc)

Utilizei o **BLoC (Business Logic Component)** como padrão de gerenciamento de estado, que é amplamente utilizado na empresa:

- **`HomeCubit`**: Gerencia o estado da tela principal
- **Estados bem definidos**: Loading, Success, Failure
- **Separação clara** entre lógica de negócio e UI
- **Reatividade** para atualizações automáticas da interface

### 📊 Estados da Aplicação

```dart
// Estados principais
- LoadingState: Carregamento inicial
- SuccessState: Dados carregados com sucesso
- FailureState: Tratamento de erros
```

## 🏗️ Padrões de Projeto Utilizados

### 🔧 **Factory Pattern**

- **`HomeCharacterDTO`**: Factory para criação de entidades a partir da API
- **`HomeListDTO`**: Factory para criação de listas paginadas
- **Conversão automática** de dados da API para entidades do domínio

### 🗄️ **Repository Pattern**

- **`HomeRepositoryInterface`**: Contrato abstrato do repositório
- **`HomeRepository`**: Implementação concreta com lógica de negócio
- **Separação de responsabilidades** entre fonte de dados e lógica de negócio
- **Inversão de dependência** através de interfaces

### 🏭 **Entity Pattern**

- **`HomeCharacterEntity`**: Entidade de domínio imutável
- **`HomeListEntity`**: Entidade para listas com informações de paginação
- **Validação de dados** e regras de negócio encapsuladas
- **Independência** da camada de dados

### 🔌 **Dependency Injection**

- **`flutter_modular`**: Sistema de injeção de dependência
- **`AppModule`**: Configuração centralizada de dependências
- **Lazy loading** de serviços e repositórios
- **Testabilidade** aprimorada com mocks

### 🎯 **Princípios SOLID Aplicados**

- **Single Responsibility**: Cada classe tem uma responsabilidade específica
- **Open/Closed**: Extensível para novos tipos de personagens sem modificar código existente
- **Liskov Substitution**: Interfaces podem ser substituídas por implementações
- **Interface Segregation**: Interfaces pequenas e específicas (IHttpClient, HomeRepositoryInterface)
- **Dependency Inversion**: Dependências de alto nível não dependem de baixo nível

## 🌐 Integração com API

### 🔌 HTTP Client

- **Dio**: Cliente HTTP robusto e configurável
- **Interceptors**: Para tratamento de erros e logs
- **Tratamento de falhas**: Mapeamento de erros da API

### 📡 Endpoints

- **Lista de personagens**: `/character` com paginação
- **Detalhes do personagem**: `/character/{id}`
- **Filtros**: Suporte a `name` e `status`

## 🎨 Design System

### 🎨 Paleta de Cores

```dart
- Primary: #87A1FA (Azul principal)
- Secondary: #CAC4D0 (Cinza secundário)
- Success: #74C365 (Verde para status vivo)
- Error: #E24B4B (Vermelho para status morto)
- Backgrounds: #1A1D21, #1C1B1F (Tons de preto)
```

### 🎭 Animações e Transições

- **Lottie**: Animações temáticas (Rick e Morty)
- **Shimmer**: Efeitos de carregamento elegantes
- **Transições suaves** entre telas
- **Feedback visual** para todas as interações

## 🧪 Testes

### 📋 Cobertura de Testes

Implementei testes de integração para garantir a robustez da aplicação:

#### Camada de Dados

- **`home_data_source_test.dart`**: Testes da fonte de dados
- **`home_repository_test.dart`**: Testes do repositório

#### Camada de Domínio

- **`get_home_characters_use_case_test.dart`**: Testes dos casos de uso
- **`get_home_character_by_id_use_case_test.dart`**: Testes de busca por ID

### 🛠️ Ferramentas de Teste

- **Mockito**: Para mocks e stubs
- **flutter_test**: Framework de testes do Flutter
- **Cobertura completa** das camadas críticas

## 📱 Funcionalidades de UX

### 🚀 Splash Screen

- **Animação Lottie** com tema Rick and Morty
- **Transição automática** após 2 segundos
- **Branding consistente** com a aplicação

### 🔍 Sistema de Busca

- **Busca em tempo real** por nome
- **Validação de entrada** com feedback visual
- **Botão de limpar** para resetar a busca
- **Debounce** para otimizar performance

### 🎯 Filtros Avançados

- **Filtro por status**: Alive, Dead, Unknown, All
- **Interface intuitiva** com chips selecionáveis
- **Estado persistente** durante a sessão
- **Combinação** com busca por nome

### ⚡ Performance e Carregamento

- **Shimmers elegantes** durante carregamento
- **Paginação inteligente** com scroll infinito
- **Cache de dados** para melhor experiência
- **Loading states** para todas as operações

## 🛡️ Tratamento de Erros

### 🚨 Sistema Robusto

- **Tratamento de falhas de rede**
- **Mensagens de erro amigáveis**
- **Botão de retry** para operações falhadas
- **Fallbacks** para cenários de erro

### 🎭 Componente de Erro

- **Design consistente** com o tema da aplicação
- **Animação Lottie** para engajamento
- **Ações claras** para o usuário
- **Integração perfeita** com o fluxo da aplicação

## 📦 Dependências Principais

```yaml
# Gerenciamento de Estado
flutter_bloc: ^9.1.1

# Injeção de Dependência
flutter_modular: ^6.3.4

# HTTP Client
dio: ^5.9.0

# Animações
lottie: ^3.1.3
shimmer: ^3.0.0

# Testes
mockito: ^5.4.4
```

## 🚀 Como Executar

### 📋 Pré-requisitos

- Flutter SDK >= 2.17.6
- Dart SDK >= 2.17.6
- Android Studio / VS Code

### ⚡ Comandos

```bash
# Instalar dependências
flutter pub get

# Executar testes
flutter test

# Executar aplicação
flutter run
```

## 🎯 Decisões de Arquitetura

### 🏗️ Por que Clean Architecture?

- **Separação de responsabilidades** clara
- **Testabilidade** superior
- **Manutenibilidade** a longo prazo
- **Escalabilidade** para projetos maiores

### 🧱 Por que BLoC?

- **Separação** entre lógica e UI
- **Testabilidade** dos estados
- **Reatividade** nativa

### 🎨 Por que Design System?

- **Consistência visual** em toda aplicação
- **Manutenibilidade** do código
- **Reutilização** de componentes
- **Escalabilidade** do design

## 🏆 Conclusão

Este projeto demonstra não apenas a implementação das funcionalidades solicitadas, mas também:

- **Excelência técnica** em arquitetura Flutter
- **Compromisso com qualidade** através de testes
- **Foco na experiência do usuário** com animações e feedback
- **Código limpo e manutenível** seguindo boas práticas
- **Adoção dos padrões** utilizados na empresa (BLoC)

A aplicação está pronta para produção e pode servir como base para projetos maiores, demonstrando a capacidade de implementar soluções robustas e escaláveis em Flutter.

---

**Desenvolvido com ❤️ para o Desafio Kode Start 2025**

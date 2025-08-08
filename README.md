# 🧪 Rick and Morty App (Flutter)

Aplicativo mobile desenvolvido em Flutter para listar personagens da série **Rick and Morty**, utilizando a [Rick and Morty API](https://rickandmortyapi.com/).

---

## 🚀 Funcionalidades

- ✅ Listagem paginada de personagens
- 🔍 Filtro por nome, espécie e gênero
- 📄 Detalhes do personagem: nome, status, espécie, gênero e localização
- 🧪 Testes automatizados de modelo, cubit e páginas
- 🧼 Arquitetura limpa usando **MVVM** com **Cubit**
- 🌐 Requisições HTTP com **Dio**
- 🎨 UI responsiva e customizada com tema

---

## 🧱 Arquitetura

O projeto segue a arquitetura MVVM:
lib/
├── core/ # Constantes e utilitários (ex: cores, fontes, rotas)
├── data/
│ ├── datasource/ # Fonte de dados (API)
│ ├── models/ # Modelos (CharacterModel, Location, etc.)
├── domain/
│ └── repository/ # Abstrações de repositórios
├── presentation/
│ ├── view_models/ # Cubits e States
│ └── views/ # Páginas da UI
├── main.dart # Ponto de entrada

## 🖥️ Telas

- **SplashScreen**: Tela inicial com logo
- **CharacterListPage**: Lista de personagens com filtros
- **CharacterDetailPage**: Detalhamento do personagem selecionado

---

## 🧪 Testes

- Modelos (`CharacterModel`, `Location`)
- Cubits (`CharacterCubit`)
- Páginas (`CharacterListPage`, `CharacterDetailPage`)

Rodar testes:

```bash
flutter test


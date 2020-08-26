# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

# Requisitos do projeto

- Ruby 2.7.1
- Rails 6.0.3.2
- yarn

# Executar o projeto

``bundle install``

``yarn install``

``rake db:create``

``db:migrate``

``rails s``

# Executar os testes

``rspec``

# Rotas

- Listar pastas root

``http://localhost:3000/folders.json``

- Listar todas as pastas

``http://localhost:3000/folders.json?all=true``

- Listar dados da pasta

``http://localhost:3000/folders/:id.json``

- Criar pasta

``http://localhost:3000/folders.json``

- Editar pasta

``http://localhost:3000/folders/:id.json``

- Excluir pasta

``http://localhost:3000/folders/:id.json``

- Adicionar arquivo

``http://localhost:3000/folders/:folder_id/files.json``

- Exlcuir arquivo

``http://localhost:3000/folders/:folder_id/files/:id.json``

Obs.: Também é possível testar através do navegador em localhost:3000

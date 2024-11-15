Aqui vai os comandos para executar cada um dos ambientes existentes. Todos devem ser escritos no terminal:
rails s (ambiente backend)
yarn serve (ambiente frontend)

para instalar as dependências do ambiente frontend, é só executar o comando: yarn install
para instalar as gems da api rails, é só executar o comando: bundle install
para rodar as migrations da api rails para que models, controllers, entre outras funcionalidades sejam executadas,
é só escrever o comando: rails db:migrate

ENDPOINTS:

Criar Equipamento:

verbo HTTP: POST
path: '/equipment'

request body: 
{
  "equipment": {
    "name": "john doe",
    "brand": "brand1",
    "equipment_type": "monitor",
    "equipment_photo": "photo.png",
    "code": 123123123,
    "local_id": 1
  }        
}

response body:
{
  "equipment": {
    "id": 1
    "name": "john doe",
    "brand": "brand1",
    "equipment_type": "monitor",
    "equipment_photo": "photo.png",
    "code": 123123123,
    "local_id": 1
  }        
}

status code: 201, created

======================================

Listar Equipamentos:

verbo HTTP: GET
path: '/equipment'

response body:
{
  {   
    "id": 1
    "name": "john doe",
    "brand": "brand1",
    "equipment_type": "monitor",
    "equipment_photo": "photo.png",
    "code": 123123123,
    "local": { 
              id: 1, 
              name: 'RH',
              created_at: '2022-06-20T22:00',
              updated_at: '2022-06-20T22:00' 
          }
  },
  {   
    "id": 2
    "name": "jane doe",
    "brand": "brand2",
    "equipment_type": "computer",
    "equipment_photo": "photo.png",
    "code": 321321321,
    "local": { 
              id: 1, 
              name: 'RH',
              created_at: '2022-06-20T22:00',
              updated_at: '2022-06-20T22:00' 
          }
  }           
}

status: 200, ok

==========================================

Editar Equipamento:

verbo HTTP: PUT
path: '/equipment/:id'

request body: 
{
  "equipment": {
    "name": "john doe",
    "brand": "brand1",
    "equipment_type": "monitor",
    "equipment_photo": "photo.png",
    "code": 123123123,
    "local_id": 1
  }        
}

status: 204, no_content

=========================================

Mostrar Equipamento

verbo HTTP: GET
path: '/equipment/:id'

response body:
{   
  "id": 2
  "name": "jane doe",
  "brand": "brand2",
  "equipment_type": "computer",
  "equipment_photo": "photo.png",
  "code": 321321321,
  "local": { 
          id: 1, 
          name: 'RH',
          created_at: '2022-06-20T22:00',
          updated_at: '2022-06-20T22:00' 
      }
  }

  status: 200, ok

=====================================

Deletar Equipamento:

verbo HTTP: DELETE
path: '/equipment/:id'

status: 204, no_content

=====================================

Listar opções de tipos de equipamento:

verbo HTTP: GET 
path: '/equipment/equipment_type_options'

response body:
{
  { "id": 0, "key": "air_conditioner"},
  { "id": 1, "key": "coffee_machine"},
  { "id": 2, "key": "computer"},
  { "id": 3, "key": "monitor"},
  { "id": 4, "key": "mouse"},
  { "id": 5, "key": "keyboard"},
  { "id": 6, "key": "television"},
  { "id": 7, "key": "router"},
}

status: 200, ok

=====================================

Cadastrar local:

verbo HTTP: POST 
path: '/locations'

request body:
{
  "local": {
    "name": "local1",
    "parent_id": 1
  }
}

obs: parent_id deve receber o id de um local já existente. Se não houver locais cadastrados ainda,
     os dados podem ser enviados assim mesmo, pois esse campo não é obrigatório.

status: 201, created
======================================

Listar locais cadastrados:

verbo HTTP: GET
path: '/locations'

response body:
{
  { "id": 0, name: "local1" },
  { "id": 0, name: "local2" },
}

status: 200, ok
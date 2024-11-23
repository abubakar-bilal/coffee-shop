# Coffee Shop

This is a Rails application for a coffee shop that allows customers to place orders and view the menu. The application uses a Sqlite database and the `jsonapi_serializer` gem to serialize data for the APIs.

## Prerequisites

- Ruby 3.3.0
- Rails 7.1.5
- Sqlite 1.4

## Getting Started

1. Navigate to the project directory: `cd coffee-shop`
2. Install the required gems: `bundle install`
3. Set credentials: `EDITOR=nano rails credentials:edit`

```
  secret_key_base: long_random_string
```

4. Create the database: `rails db:create`
5. Run the database migrations: `rails db:migrate`
6. Seed the database with sample data (optional): `rails db:seed`
7. Start the server: `rails s`

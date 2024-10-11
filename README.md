# README
# Device Registry

## Project Description

Device Registry is a Ruby on Rails application designed to manage the assignment of devices to users. Users can register, assign, and return devices, while the system enforces appropriate authorization and validation mechanisms.

## Features

- User registration
- Device assignment to users
- Device return
- Authorization checks before executing actions

## Requirements
- Ruby 3.2.3
- SQLite3
- Ruby on Rails (corresponding version)

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/5ik3/device_registry_assignment
    cd device_registry

2. **Install dependencies**
    ```bash
    bundle install
    ```
    *if there is a problem with mismatching gem versions please run **gem update**, it should solve the problem*

3. **Set up the database**
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Run the server**
    ```bash
    rails server
    ```

5. **Run the tests**
    ```bash
    rspec
    ```

## Testing

The project includes unit and integration tests written in RSpec. The tests cover various aspects of the business logic, including:

Device assignments to users
Error verification for unauthorized actions
Validations in models
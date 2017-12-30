# Sample Application - Ruby on Rails - Hello World!

## Setting up the environment (on Mac OS)

* Installing rbenv using Homebrew
  `$ brew install rbenv ruby-build`

* Initalizing rbenv
  `$ rbenv init`

* Installing the desired version of ruby using rbenv
  `$ rbenv install 2.3.3`

* Tell the system there's a new version of Ruby
  `$ rbenv rehash`

* (Optional) Set this version as global 
  `$ rbenv global 2.3.3`

* Install Rails
  `$ gem install rails -v 5.1.4`

Restart the shell to make sure all the settings are properly updated.

## Setting up the Hello World Application

* To get a skeleton Rails application:
  `$ rails new book_shop_app`

This will automatically create a directory named hello_app with all the necessary directories and files.

* (Optional) Add any other gems required in Gemfile and run :
  `$ bundle install`

To install only the gems that are required for development env : 
  `$ bundle install --without production`

* Start the Rails Server using the command: 
  `$ rails server`

Now, hit [`localhost:3000`](http://localhost:3000) on your browser. (`Ctrl + C` to stop the Rails server)

### Add a Hello Action to the Application Control. 

* In `app/controllers/application_controller.rb`, add the following function :
  
  ```ruby
  def hello
    render html: "hello, world!"
  end
  ```
### Add the route 

* Set the root route in `config/routes.rb` :

    ```ruby
    Rails.application.routes.draw do
      root 'application#hello'
    end
    ```

Now, if we hit [`localhost:3000`](http://localhost:3000) on your browser, we get "Hello World!" (`Ctrl + C` to stop the Rails server)

------------------------------------------------

## Extending the Hello Word Application to Book Shop Application

* Change the title of the application to `Book Shop` in `layouts\application.html.erb` file.

### Generating a books data model :
  
* To generate a model (or table) called `Book` with two Attributes `name` and `Author` :
  `$ rails generate scaffold Book name:string author:string`

* Migrate the database (to update the database with the model) :
  `$ rails db:migrate`

Now, start the Rails server using the command `$ rails server` and hit  [`localhost:3000\books`](http://localhost:3000/books) 

You will be automatically taken to the books page where you can Create, Edit and Delete books.

### Generating a users data model :
  
* To generate a model (or table) called `User` with two Attributes `name` and `email` :
  `$ rails generate scaffold User name:string email:string`

* Migrate the database (to update the database with the model) :
  `$ rails db:migrate`

Now, start the Rails server using the command `$ rails server` and hit  [`localhost:3000\users`](http://localhost:3000/users) 

You will be automatically taken to the users page where you can Create, Edit and Delete users.

### Changing the root route to `books#index` :

* Add `root 'books#index'` to `config/routes.rb` file. The content will then look like this :

  ```ruby
  Rails.application.routes.draw do
    resources :books
    resources :users
    root 'books#index'
  end
  ```

Hit the command `$rails server` and go to [`localhost:3000`](http:\\localhost:300) on your browser to view the main page of the Application : Books

#### Reference

[Ruby on Rails Tutorial](https://www.railstutorial.org/book/), by Michael Hartl.


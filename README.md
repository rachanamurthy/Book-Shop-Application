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

------------------------------------------------

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

Hit the command `$rails server` and go to [`localhost:3000`](http:\\localhost:3000) on your browser to view the main page of the Application : Books

#### Reference

[Ruby on Rails Tutorial](https://www.railstutorial.org/book/), by Michael Hartl.

------------------------------------------------

### Rails Console  

* Use the rails console by hitting the command `$ rails c`.

* On the rails console : 
  `> Book.all`
  `> User.all`

* To create a new Book :
  `> Book.create(name: "Rage of Angels", author: "Sidney Sheldon")`

* To view the first Book created :
  `> Book.first`

------------------------------------------------

### Dockerizing the Rails Application

* Write a dockerfile 

* Run the command : `docker build -t demo .` to build the image from the Dockerfile.

* Run the command: `docker run -d -p 32775:3000 demo` which would start the container in detached mode

* NOTE : You can use any other port number which is not allocated already on your local machine, instead of `32775`. 

* Run `docker ps` to verify that the container is up and running.

* Hit [`localhost:32775`](http:\\localhost:32775) on your browser.

Your application is now running on the container.

------------------------------------------------

### Using Environment Variables 

* Add the following in function `Rails.application.configure` in `config/development.rb` file :

```
config.secret_key_base = ENV["SECRET_KEY_BASE"]
```

* Add ENV variables in `config/database.yml` file.

* Build image - `docker build -t demo .`

* Create a file `env.list` This file should use the syntax `<variable>=value`:
  ```
  $ cat env.list
  # This is a comment
  VAR1=value1
  VAR2=value2
  ```

* Start the container with the command `docker run -d -p 32775:3000 --env-file env.list demo`

* Hit [`localhost:32775`](http:\\localhost:32775) to verify that the application is running as expected.


------------------------------------------------


### Pushing the image to Docker Hub

* Create an account on [dockerhub](https://hub.docker.com/) (If you haven't already)

* Run `docker login` on your terminal, to login into docker hub. 

* Run `docker images` to get details about the image.

* Tag the docker image that you would be pushing using the command `docker tag <image-id> <yourhubusername>/<image-name>:latest`

Example : `docker tag 5d7bc07324fe rachanamurthy/rubyapp:latest`

If you run  `docker images` again, you can see that a new image with name `<yourhubusername>/<image-name>` would have been created.

* Run the command `docker push <yourhubusername>/<imagename>` to push the image to docker hub. 

* You can log into dockerhub and check if the image has been pushed. 

* Now, you can pull the docker image using the command `docker pull rachanamurthy/rubyapp` or start a container using the command `docker run -d -p 32775:3000 --env-file env.list rachanamurthy/rubyapp` 

------------------------------------------------

### Deploying to a Single Docker Container Platform on AWS

* Install and configure EB CLI.

* Create a file named `Dockerrun.aws.json` specifying the image name and the port bindings. 

NOTE : You do not have to specify image name if you already have a Dockerfile in the root directory.

* Run the command `eb init` 

* Choose `docker` (not multi-container docker).

* Add a file `.ebextensions/environment_variables.config` that has all the values for environment variables.

The file would look something like this:
```
option_settings:
  aws:elasticbeanstalk:application:environment:
    DATABASE_HOSTNAME: www.example.com/api
    DATABASE_NAME: dev
    DATABASE_USERNAME: admin
    DATABASE_PASSWORD: xyz
    SECRET_KEY_BASE: jksdkjshdksh
```


* Commit the changes using the command `git commit -m "Add Deockerrun.aws.json and .ebextensions\environment_variables.config"`

* Run the command `eb create`. This will create the environment. 

You can have multiple environments - Dev, Staging, Production. You can directly deploy application code from git, by checking into the branch and then  `eb deploy`.

* Further, any other changes made in the code can be deployed using the command `eb deploy` 

------------------------------------------------
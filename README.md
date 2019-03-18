Rails Engine is the first project for Back-End Engineering Module 3 at Turing School of Software and Design.This was a solo project.

The purposes of building this project include:

* Learn how to to build Single-Responsibility controllers to provide a well-designed and versioned API.

* Learn how to use controller tests to drive your design.

* Use Ruby and ActiveRecord to perform more complicated business intelligence.


Getting Started
* These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

This project uses these gems:
* Ruby version ruby '2.4.1'
* gem 'rails', '~> 5.2.2'
* gem 'money'
* gem 'fast_jsonapi'
* gem 'ruby-progressbar'
* gem 'faker'

----for :development, :test
* gem 'rspec-rails'
* gem 'factory_bot_rails'
* gem 'database_cleaner'
* gem 'nyan-cat-formatter'
* gem 'pry'
* gem 'simplecov', require: false
* gem 'shoulda-matchers'


Prerequisites
* To install dependencies after cloning the app, run in the command line: bundle install
* To setup the database, run: rails db:create rails db:migrate
* To load and migrate data to database run : rake import:all from command line

To run the server on localhost:3000, run: rails s from command line
Please take a look at 'config/routes.rb' file for all the available routes.

Running the tests

Run 'rspec' in the terminal.


Author:

Manoj Panta

To submit any PR please follow the instrctions below:
* Fork it (https://github.com/manojpanta/RailesEngine)
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -m 'Add some feature')
* Push to the branch (git push origin my-new-feature)
* Create a new Pull Request

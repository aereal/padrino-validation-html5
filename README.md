# Padrino::Validator::HTML5

padrino-validator-html5.gem supports HTML5 (client-side) form validations.

## Installation

### from RubyGems

add the following to your project's Gemfile:

    # Gemfile
    gem 'padrino-validator-html5'

or, do you like living on the edge?

    # Gemfile
    gem 'padrino-validator-html5',
      :git => 'git://github.com/aereal/padrino-validator-html5.git'

## Usage

Padrino::Validationo::HTML5 uses Padrino extension, and so you have to write some code to start to use this.

    # app/app.rb
    register Padrino::Validationo::HTML5

And then, add some validations to your model which based ActiveModel:

    # models/post.rb
    class Post < ActiveRecord::Base
      validate_presence_of :title
    end

You also have to use FormBuilder helpers:

    # app/views/example.haml
    - form_for @post, '/post' do |f|
      %p
        = f.text_field :title
      %p
        = f.text_area :body
      %p
        = f.submit "Submit"

You may get such HTML as the following:

    # rendered app/views/example.haml
    <form method="post" ...>
      <input type="text" name="post[title]" ... required="required" />
      ...
    </form>

## Features

Padrino::Validationo::HTML5 currently supports the following validators:

 * ActiveModel::Validations::InclusionValidator
 * ActiveModel::Validations::LengthValidator
 * ActiveModel::Validations::PresenceValidator

## AUTHOR

aereal <aereal@kerare.org>

## SEE ALSO

 * [Padrino](http://padrinorb.com/)
 * [HTML-ValidationRules](https://github.com/kentaro/HTML-ValidationRules)

## LICENSE

See LICENSE.txt


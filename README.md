# HasTags

HasTags is a lightweight library for easily adding tags to your ActiveRecord models.

## Installation

Add this line to your application's Gemfile:

    gem 'has_tags'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_tags

## Usage

First, you must run <code>rails g has_tags:install</code> to install the tag migrations.

Once the migrations are installed, run <code>rake db:migrate</code>.

Now choose a model to add tags to. Let's use <code>Post</code> as an example. All you have to do is add <code>has_tags</code> to the model class definition:

  ```ruby
  class Post < ActiveRecord::Base
    has_tags
  end

  ```

Your post class can now have associated tags.

To set tags on a <code>Post</code> instance, whitelist the <code>tag_list</code> parameter in your controller:

```ruby
class PostController < ActiveRecord::Base
  # ...

  private

  def post_params
    params.require(:post).permit(:param1, :param2, :tag_list)
  end
end
```

<code>tag_list</code> should be a string with tags separated by commas, or colons to create a context tag.

### Examples

For creating top-level tags, a user can type in tags only separated by commas:

"Sports, Food"

For creating tags within tags, where to top-level tag acts as the context or parent for the child tag, separate the tags by colons:

"Sports:Hockey, Food"

This creates three tags: Sports, Hockey and Food. Sports is now the context in which Hockey lives. Now we can call:

```ruby
context = Tag.find_by(name: "Sports")

context.tags # => Hockey tag
```

The context tag syntax can be nested like so:

"Sports:Hockey:Strategy"

```ruby
strategy = Tag.find_by(name: "Strategy")

hockey = strategy.context # => Hockey tag

hockey.context # => Sports tag
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

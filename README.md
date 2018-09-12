# Soulpad

Soulpad is an ecommerce app built using spree commerce. the same code base is installed in multiple timezones, and uses ENV vars to detect the current timezone at runtime (these are set in the vhosts). The App makes heavy use of Rails Engines to provide additional functionality over the standard spree features.


Development
----------------------

```shell
git clone https://github.com/mvanio/SoulPad-2017
cd SoulPad-2017
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake spree_sample:load
rails server
```

Browse Store
----------------------

http://localhost:3000

Browse Admin Interface
----------------------

http://localhost:3000/admin

Generate a new admin user by running `rake spree_auth:admin:create`.

Extensions
----------------------

Spree Extensions provide additional features not present in the Core system.

* affiliate_engine (offers)
* dynamic_content_management_engine
* features_engine (product banner/slider)
* news_engine (faqs)
* spree_sales_prices_engine
* testimonials_engine
* watermark_engine

## Testing

Testing is a bit limited, a basic rspec suit is included.

Run Engine tests from the host application and reference the engine spec
folder/file directly

## ENV Variables

Environment variables need to be set manually on the server

```shell
$ export LOCALE='en-GB'
$ export SPREE_USE_PAPERCLIP='true'
```

## Asset Precompile

`bundle exec rake RAILS_ENV=production assets:precompile`

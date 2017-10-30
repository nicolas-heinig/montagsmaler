# MONTAGSMALER

This application will be used as a starting point for all blackshirt projects

## Environment Variables ##

To work with the application, remove `-example` from `.env-example` and set the variables for your needs

## Damn nice gems

purpose | gem
------- | ---
Secure authentication | [devise](https://github.com/plataformatec/devise)
Soft delete | [paranoia](https://github.com/rubysherpas/paranoia)
Testing framework | [rspec](https://github.com/rspec/rspec-rails)
Very nice debugging | [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug)
Ruby linter | [rubocop](https://github.com/bbatsov/rubocop)
Easy configuration of rails apps | [config](https://github.com/railsconfig/config)
Generate fake data for tests | [faker](https://github.com/stympy/faker)
Emulate user interactions | [capybara](https://github.com/teamcapybara/capybara)
Simple authorization | [pundit](https://github.com/elabs/pundit)
Model versioning | [paper_trail](https://github.com/airblade/paper_trail)
Post messages to slack | [slack-notifier](https://github.com/stevenosloan/slack-notifier)
Analytics | [ahoy](https://github.com/ankane/ahoy)
File upload | [carrierwave](https://github.com/carrierwaveuploader/carrierwave)
HTML Preprocessing | [slim](https://github.com/slim-template/slim-rails)
Forms | [simple_form](https://github.com/plataformatec/simple_form)
Provide nice and easy charts | [chartkick](https://github.com/ankane/chartkick)
Nice interactive javascript maps | [leaflet-rails](https://github.com/axyjo/leaflet-rails)
Easy WYSIWYG-Editor | [bootsy](https://github.com/volmer/bootsy)
Glyphicons for bootstrap v4 | [bootstrap-glyphicons](https://rubygems.org/gems/bootstrap-glyphicons)
Slideshow and Zoom functionality | [fancybox](https://github.com/kyparn/fancybox2-rails)
Markdown, Latex and Math parsing | [kramdown](https://github.com/gettalong/kramdown)
Nice Code Editor | [codemirror](https://github.com/fixlr/codemirror-rails)

## Development Guidelines

### Styles :D

* Use bootstrap classes, you bitch
* Glyphicons are deprecated. Instead use the font awesome icons. Preferably like this: `= fa_icon 'trash', text: t(:delete)`
* When you need special styling create sass partial in pages/ after this scheme `_controller_action.sass`

### Backend

* Before committing and pushing to the remote make sure `rspec` and `rubocop` are green
* Try to keep the code clean and easy to read

### Git workflow

* When you make a pull request that is **not** mergeable, applay `[WIP]` or `[REVIEW]` label
* Always assign at least one reviewer
* Discuss :)

## Error Reporting with Sentry

* Create free acount on https://sentry.io/
* Implement by following this guide: https://github.com/getsentry/raven-ruby

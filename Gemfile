source 'https://rubygems.org'

# Can't use `gemspec` to pull in dependencies, because the landrush gem needs
# to be in the :plugins group for Vagrant to detect and load it in development

gem 'rubydns', '0.8.5'
gem 'childprocess'
gem 'rake'

# Vagrant's special group
group :plugins do
  gem 'landrush', path: '.'
end

group :test do
end

group :development do
  gem 'vagrant',
    :git => 'git://github.com/mitchellh/vagrant.git',
    :ref => 'v1.7.1'

  gem 'byebug'
  gem 'mocha'
end

# Appflux Ruby
---
[![Maintainability](https://api.codeclimate.com/v1/badges/64eff633689a54b902cf/maintainability)](https://codeclimate.com/github/appflux/appflux-ruby/maintainability) [![Gem Version](https://badge.fury.io/rb/appflux_ruby.svg)](https://badge.fury.io/rb/appflux_ruby)

Appflux is an exception notification library for Rack/Rails application. It is extremely lightweight, easy to setup and always free. Signup on appflux.io, create a project and find your keys to setup your application. The exceptions are delivered to your email as well as can be seen on the dashboard. Appflux also offers a simple and classic messaging platform.

## Why do we need another exception notification library?
1. While [exception_notification](https://github.com/smartinez87/exception_notification) is a good open source library, it is really painful to setup. The notification messages are very verbose and often spam the inbox. And... it does not come with a GUI. Appflux offers a decent simplistic dashboard that most open source solutions lack.
2. There are a lot of very good commercial exception notification softwares out there. But they are more focussed on managers, not developers.

## Some Features
1. Automatically reports unhandled exceptions.
2. Reports handled exceptions.
3. Automagically supports Delayed Job and Sidekiq.
4. Figures out common information (from commonly used gems) used to debug a Rails application.
5. Send custom diagnostic information.
6. Nicely integrates with Appflux.io dashboard.

## Requirements
1. Ruby 1.9.3 or greater
2. Rails 3.0 or greater, Grape, Sinatra or any other Rack application.

## Setup
> If you have more than one project, you should first create an organization.
1. Sign up on appflux.io.
2. Confirm your account and create a project.
3. Follow the instructions on the setup page.

## What's more ?
Appflux offers an integrated platform to monitor, analyze and discuss your ruby application. You can:
1. Get notified of exceptions.
2. Post messages and discuss issues with other collaborators and clients.
3. Keeps all project related files.

## What's cookin' ?
1. Support for out-of-the-box user behavior analysis for Rails applications.
2. Cohort analysis for Rails applications.

## Help
1. hi@appflux.io
2. [@_guptashubham](https://twitter.com/_guptashubham)
3. [@appfluxhq](https://www.twitter.com/appfluxhq)

## License

The Appflux ruby gem is a free software released under the MIT License. See [LICENSE.txt](https://github.com/appflux/appflux-ruby/blob/master/LICENSE.txt) for details.

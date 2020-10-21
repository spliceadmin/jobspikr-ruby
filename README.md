# JobsPikr API wrappers for ruby

Wraps the JobsPikr API for convenient access from ruby applications.

Documentation for the JobsPikr REST API can be found here: https://app.jobspikr.com/

## Setup

    gem install jobspikr-ruby

Or with bundler,

```ruby
gem "jobspikr-ruby"
```

## Getting Started

Below is a complete list of configuration options with the default values:
```ruby
Jobspikr.configure({
  base_url: "https://api.jobspikr.com/v2",
  logger: Logger.new(nil),
  client_id: <JOBSPIKR_CLIENT_ID>,
  client_auth_key: <JOBSPIKR_CLIENT_AUTH_KEY>,
})
```

## Disclaimer

This project and the code therein was not created by and is not supported by JobsPikr, Inc or any of its affiliates.


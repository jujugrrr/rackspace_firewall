# rackspace_firewall

## Supported Platforms

- CentOS 6.5
- Ubuntu 12.04
- Ubuntu 14.04

## Requirements

### Cookbooks

- `firewall`

## Recipes

### default
- what it does
  - Install default firewall rules for Rackspace services

## Usage

### include recipe

```ruby
include_recipe 'rackspace_firewall'
```

### rackspace_firewall

- single node (app and db):
```json
{
    "run_list": [
      "recipe[rackspace_firewall::default]"
    ]
}
```

# Contributing

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md


# Authors
Authors:: Matthew Thode <matt.thode@rackspace.com>

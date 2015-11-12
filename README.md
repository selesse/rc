# Rock::Climbing

[![Build status](https://travis-ci.org/selesse/rc.png)](https://travis-ci.org/selesse/rc)

This is a toy project in Ruby to help calculate certain metrics associated
with rock climbing. Feedback/advice welcome -- this is some of my first Ruby
code.

## Usage

```ruby
#!/usr/bin/env ruby

require 'rock/climbing'

# Store the rock climbing results in a CSV like I do
climbing_sessions = SimpleCsvDeserializer::deserialize(File.read('rock_climbing.csv'))

# Or create your own climbing sessions programmatically
climbing_sessions = [ ClimbingSession.new(date: Time.now, gym_name: 'This Rox', climbs: [ ... ]) ]

reporter = Reporter.new(climbing_sessions)
reporter.report
```

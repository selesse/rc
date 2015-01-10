require 'csv'
require 'time'

# Parse something like
#  Date,Climbs,,,,,,,
# 2014-11-04,5.5,5.7,5.8,5.8-,5.8 (F),,,
# 2014-11-26,5.6,5.7,5.8,5.8-,5.7+,5.8 (F),,
# 2014-12-22,5.8,5.6+,5.7 (F),5.8 (F),5.7+ (F) ,,,
# 2014-12-28,5.6,5.7+ (50%),5.8- (70%),5.6 * 4,,,,
# 2014-12-30,5.5 * 2,5.7 sent,5.7+ sent,5.8-,5.8,,,
# 2015-01-03,5.6+ sent ,5.7+ sent,5.8,5.8,5.7 sent ,5.8- (90%) ,,
# 2015-01-06,5.6+ sent,5.7 sent ,5.7+ sent ,5.8-,5.7+,5.8,5.8- (90%),5.6 x 2.7

class SimpleCsvDeserializer
  def self.deserialize(file_contents)
    climbing_sessions = []

    climbing_sessions_raw = CSV.new(file_contents).to_a[1..-1]
    climbing_sessions_raw.each do |raw_climbing_session|
      climbs = []

      gym_name = raw_climbing_session.first
      date = Time.parse raw_climbing_session[1]
      climbs_raw = raw_climbing_session[2..-1].select { |session| !session.nil? }

      climbs_raw.each { |raw_climb_string| climbs << self.create_climb(raw_climb_string) }

      climbing_sessions << ClimbingSession.new(date: date, gym_name: gym_name, climbs: climbs)
    end

    climbing_sessions
  end

  def self.create_climb(raw_climb_string)
    raw_climb_string.strip!

    rating = raw_climb_string[/([0-9]\.([0-9]+ *[-+]?))/, 1]
    rating.strip!

    percentage = raw_climb_string[/.* \((\d+)%\)/, 1]
    times = raw_climb_string[/.* [x*] (\d+)/, 1]
    sent = raw_climb_string.include? 'sent'
    failed = raw_climb_string.include? '(F)'

    unless percentage.nil?
      percentage = percentage.to_f / 100.0
    end

    unless times.nil?
      times = times.to_i
    end

    Climb.new(rating, percentage: percentage, times: times, sent: sent, failed: failed)
  end
end

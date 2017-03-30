require "bundler/setup"
require "harvest_automatic"
require "active_support/core_ext/numeric/time"
require "active_support/core_ext/array/grouping"
require "awesome_print"

def days_during_time_period(starting_date, ending_date)
  date  = starting_date
  dates = []
  while date < ending_date do
    dates << date
    date += 1.day
  end
  dates
end

def week_columns(days)
  days.in_groups_of(7).collect do |week|
    "#{week.first.strftime('%F')} through  #{week.last.strftime('%F')}"
  end
end

def find_entry(entries, user, start)
  entries.detect do |e|
    e[:name] == "#{user[:first_name]} #{user[:last_name]}" &&
    e[:begin_date] == start
  end
end

script_start   = Time.now
all_users      = HarvestAutomatic.client.users.all
active_users   = all_users.select { |u| u['is_active'] }
# ids            = [1062382, 1146050]
# active_users   = all_users.select { |u| ids.include?(u['id']) }
starting_date  = Time.now - ( 1.week + 1.day )
ending_date    = Time.now - 2.day
days           = days_during_time_period(starting_date, ending_date)
entries        = []
header_columns = ['name', 'client'].concat(week_columns(days))

active_users.each do |user|
  user_hash = {
    name: "#{user['first_name']} #{user['last_name']}",
    id:   user['id']
  }
  days.in_groups_of(7) do |week|
    entry = user_hash.merge(
      begin_date: week.first.strftime('%F'),
      end_date:   week.last.strftime('%F'),
      entries:    [],
      clients:    []
    )
    week.each do |date|
      time_entries = HarvestAutomatic.client.time.all(date, user['id'])
      time_entries = time_entries.collect do |time_entry|
        { name: time_entry['client'], hours_spent: time_entry['hours'] }
      end
      entry[:entries].concat(time_entries)
    end
    entries << entry
  end
end

clients = entries.flat_map { |u| u[:entries] }.map { |e| e[:name] }.uniq

transformed_entries = []

entries.each do |entry|
  user_entries = entries.select { |u| u[:name] == entry[:name] }
  clients      = user_entries.flat_map { |u| u[:entries] }.map { |e| e[:name] }.uniq
  clients.each do |client|
    client_entries = entry[:entries].select { |e| e[:name] == client }
    total_hours = if client_entries.present?
      client_entries.inject(0) { |sum, e| sum + e[:hours_spent] }
    else
      0
    end
    client_hash = { name: client, hours_spent: total_hours }
    entry[:clients] << client_hash
  end
  transformed_entries << entry
end

transformed_entries.map { |e| e.delete(:entries) }
rows = [header_columns]

active_users.each do |user|
  week_columns(days).each do |week_label|
    week_start = week_label.split(' through ').first
    entry = find_entry(transformed_entries, user, week_start)
    entry[:clients].each do |client_entry|
      row_entry = []
      header_columns.each do |col|
        column = case col
        when 'name'
          entry[:name]
        when 'client'
          client_entry[:name]
        else
          e = find_entry(transformed_entries, user, col.split(' through ').first)
          c_entry = e[:clients].detect { |c| c[:name] == client_entry[:name] }
          c_entry[:hours_spent]
        end
        row_entry << column
      end
      rows << row_entry
    end
  end
end

CSV.open("time_report.csv", "wb") do |csv|
  rows.uniq.each { |row| csv << row }
end

script_end = Time.now

duration = script_end - script_start

puts "Script took #{duration} seconds to run"
puts "report written to time_report.csv"

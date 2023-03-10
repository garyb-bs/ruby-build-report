# frozen_string_literal: true

require 'rubygems'
require 'rest-client'
require 'json'
require 'net/http'

build_id = ARGV[0]
limit = 100
offset = 0
File.write('output.html',"<!DOCTYPE html><html><head><style>table {  font-family: arial, sans-serif;  border-collapse: collapse;  width: 100%;}td, th {  border: 1px solid #dddddd;  text-align: left;  padding: 8px;}</style></head><body><table>")
File.write('output.html', "<tr><th>Project Name</th><th>Build Name</th><th>Session Name</th><th>Device</th><th>OS</th><th>Status</tr>", mode: 'a')
loop do
  base_url = "https://#{ENV["BROWSERSTACK_USERNAME"]}:#{ENV["BROWSERSTACK_ACCESS_KEY"]}@api.browserstack.com/app-automate/builds/#{build_id}/sessions.json?limit=#{limit}&offset=#{offset}"
  results = RestClient.get(base_url)
  results_json = JSON.parse(results.body)
  if !results_json.empty?
    (0..results_json.length - 1).each do |i|
      automation_session = results_json[i]['automation_session']
      browser_url = automation_session['browser_url'].sub! '/builds', '/dashboard/v2/builds'
      session_name = !automation_session['name'].empty? ? automation_session['name'] : automation_session['hashed_id']
      status = automation_session['status']
      color = 'black'
      if status == 'passed'
        color='green'
      elsif status == 'failed'
        color = 'red'
      elsif status == 'error'
        color = 'red'
      elsif status == 'timeout'
        color = 'yellow'
      end

      File.write('output.html', "<tr><td>#{automation_session['project_name']}</td><td>#{automation_session['build_name']}</td><td><a href=#{browser_url} target='_blank'>#{session_name}</a></td><td>#{automation_session['device']}</td><td>#{automation_session['os']} #{automation_session['os_version']}</td><td><p style='color:#{color}'>#{automation_session['status']}</p></tr>", mode: 'a')
    end
  else
    break
  end
  offset += limit
end
File.write('output.html',"</table></body></html>", mode: 'a')

# Project Name - Build Name - Session Name - Device - OS - Status - Reason - 

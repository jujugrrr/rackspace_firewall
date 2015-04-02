# Encoding: utf-8
#
# Cookbook Name:: rackspace_firewall
# Recipe:: default
#
# Copyright 2014, Rackspace Hosting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

rules = build_rackspace_rules

firewall 'iptables' do
  action :enable
  provider Chef::Provider::FirewallIptables
end

firewall_rule 'allow world to ssh' do
  provider Chef::Provider::FirewallRuleIptables
  port 22
  source '0.0.0.0/0'
  action :allow
  only_if { node['firewall']['allow_ssh'] }
end

rules.each do |rule|
  firewall_rule "#{rule['desc']}-#{rule['position']}" do
    provider Chef::Provider::FirewallRuleIptables
    source    rule['src']
    direction rule['chain'].to_sym
    action    rule['action'].to_sym
  end
end

firewall_rule 'Loopback' do
  provider Chef::Provider::FirewallRuleIptables
  interface 'lo'
  direction :in
  action    :allow
end

firewall_rule 'Allow established' do
  provider Chef::Provider::FirewallRuleIptables
  raw       "INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT"
  action    :allow
end

firewall_rule 'Drop not allowed' do
  provider Chef::Provider::FirewallRuleIptables
  source    '0.0.0.0/0'
  action    :reject
end

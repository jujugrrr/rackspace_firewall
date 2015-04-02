# Encoding: utf-8

require_relative 'spec_helper'

describe iptables do
  it { should have_rule('-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT') }
end

describe iptables do
  it { should have_rule('-A INPUT -p tcp -m tcp -m comment --comment.*Drop not allowed.* -j REJECT --reject-with icmp-port-unreachable') }
end

describe iptables do
  it { should have_rule('-A INPUT -i lo -p tcp -m tcp -m comment --comment.*Loopback.* -j ACCEPT') }
end

describe iptables do
  it { should have_rule('-m comment --comment.*Bastion') }
  it { should have_rule('-m comment --comment.*Monitoring') }
  it { should have_rule('-m comment --comment.*Support') }
end

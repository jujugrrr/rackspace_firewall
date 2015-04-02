def download_rackspace_rules
  require 'net/http'
  uri = URI.parse('https://raw.githubusercontent.com/jujugrrr/rackspace_firewall/master/files/default/rules.list')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.get(uri.request_uri).body
end

def build_rackspace_rules
  rules = []
  download_rackspace_rules.each_line do |line|
    next if line.match('^#|^$')
    line = line.gsub(/ |'/, '').chomp
    rule = {}
    rule['chain'], rule['src'], rule['action'], rule['position'], rule['desc'] = line.split(',')
    rules << rule
  end
  rules
end

require 'rubydns'

module VagrantRubydns
  class Server

    INTERFACES = [
      [:udp, "0.0.0.0", 10053],
      [:tcp, "0.0.0.0", 10053]
    ]
    Name = Resolv::DNS::Name
    IN = Resolv::DNS::Resource::IN

    def self.upstream
      @upstream ||= RubyDNS::Resolver.new([[:udp, "8.8.8.8", 53], [:tcp, "8.8.8.8", 53]])
    end

    def self.configfile
      Pathname('.vagrant_dns.json')
    end

    def self.run
      server = self
      RubyDNS::run_server(:listen => INTERFACES) do
        match(/vagrant.dev/, IN::A) do |transaction|
          ip = Config.get(transaction.name)
          if ip
            transaction.respond!(ip)
          else
            transaction.passthrough!(server.upstream)
          end
        end

        # Default DNS handler
        otherwise do |transaction|
          transaction.passthrough!(server.upstream)
        end
      end
    end
  end
end
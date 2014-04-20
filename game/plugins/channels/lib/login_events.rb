module AresMUSH
  module Channels
    class LoginEvents
      include Plugin
    
      def on_char_connected(args)
        client = args[:client]
        channels = client.char.channels
        Global.client_monitor.clients.each do |other_client|
          common_channels = find_common_channels(channels, other_client)
          other_client.emit "#{common_channels} #{t('channels.has_connected', :name => client.name)}"
        end
      end
      
      def on_char_disconnected(args)
        client = args[:client]
        channels = client.char.channels
        
        Global.client_monitor.clients.each do |other_client|
          common_channels = find_common_channels(channels, other_client)
          other_client.emit "#{common_channels} #{t('channels.has_disconnected', :name => client.name)}"
        end
        
        channels.each do |c|
          Channels.set_gagging(client.char, c, false)
        end
        client.char.save!        
      end
      
      def find_common_channels(channels, other_client)
        their_channels = other_client.char.nil? ? [] : other_client.char.channels
        intersection = channels & their_channels
        intersection = intersection.map { |c| c.display_name(false) }
        Channels.name_with_markers(intersection.join(", "))
      end
    end
  end
end

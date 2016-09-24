module AresMUSH
  module Chargen
    class AppCmd
      include CommandHandler
      include CommandRequiresLogin
      
      attr_accessor :name

      def crack!
        self.name = cmd.args.nil? ? client.name : trim_input(cmd.args)
      end
      
      def check_can_review
        return nil if self.name == client.name
        return nil if Chargen.can_approve?(client.char)
        return t('dispatcher.not_allowed')
      end
      
      def handle        
        ClassTargetFinder.with_a_character(self.name, client) do |model|
          if (model.is_approved)
            if (model == client.char)
              client.emit_failure t('chargen.you_are_already_approved')
            else
              client.emit_failure t('chargen.already_approved', :name => model.name)
            end
            return
          end
          
          template = AppTemplate.new(model)
          client.emit template.render
        end
      end      
    end
  end
end
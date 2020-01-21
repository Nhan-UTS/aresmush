module AresMUSH
  module Utils
    class NotesCmd
      include CommandHandler
      
      attr_accessor :target, :section

      def parse_args
        if (!cmd.args)
          self.target = enactor_name
          self.section = 'player'
        else
          args = cmd.parse_args(ArgParser.arg1_slash_optional_arg2)
          if (args.arg2)
            self.target = titlecase_arg(args.arg1)
            self.section = downcase_arg(args.arg2)
          else
            self.target = enactor_name
            self.section = downcase_arg(args.arg1)
          end
        end
      end
      
      def required_args
        [ self.section ]
      end
      
      def check_section
        return t('notes.invalid_notes_section', :sections => Utils.note_sections.join(', ')) if !Utils.note_sections.include?(self.section)
        return nil
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target, client, enactor) do |model|
          
          if (!Utils.can_access_notes?(model, enactor, self.section))
            client.emit_failure t('dispatcher.not_allowed')
            return
          end
          
          text = model.notes_section(self.section)
          title = t("notes.notes_#{section}_title", :name => model.name)
          template = BorderedDisplayTemplate.new text, title
          client.emit template.render
        end
      end
    end
  end
end

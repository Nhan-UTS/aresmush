module AresMUSH
  module Utils
    class NoteDeleteCmd
      include CommandHandler

# Adding a new "section" to notes ~ skew Nov-2019
# Usage:
# note/delete title=text - del note on yourself (note to self!)
# note/delete player=title/txt - del note on a player, they can see it.
# note/delete player/admin=title/txt - del an admin note on player, only staff can see it.
      
      attr_accessor :name, :target, :section

      def parse_args
        # First, break into 2 arguements, before+after the =
        args = cmd.parse_args(ArgParser.arg1_equals_arg2)

        # Next, check if it's an "admin" note in the first part. If so, staff-side.

        if (args.arg1.include?("admin") )
          self.target = args.arg1.first("/")
          self.section = 'admin'
          self.name = titlecase_arg(args.arg2.first("/"))
          self.text = trim_arg(args.arg2.rest("/"))

        elsif (args.arg2.include?("/"))
          self.target = titlecase_arg(args.arg1)
          self.section = 'story'
          self.name = titlecase_arg(args.arg2.first("/"))
          self.text = trim_arg(args.arg2.rest("/"))

        else
          self.target = enactor_name
          self.section = 'player' 
          self.name = titlecase_arg(args.arg1)
          self.text = trim_arg(args.arg2)
        end
      end
      
      def required_args
        [ self.name ]
      end
      
      def check_is_allowed
        return nil if self.section == 'player' && self.target == enactor_name
        return nil if Utils.can_access_notes?(enactor)
        return t('dispatcher.not_allowed')
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target, client, enactor) do |model|
          notes = model.notes_section(self.section)
        
          if (!notes.has_key?(self.name))
            client.emit_failure t('notes.note_does_not_exist')
            return
          end
        
          notes.delete self.name
          model.update_notes_section(self.section, notes)

          client.emit_success t('notes.note_deleted')
        end
      end
    end
  end
end

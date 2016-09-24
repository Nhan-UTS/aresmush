module AresMUSH
  module Groups
    class GroupListTemplate < ErbTemplateRenderer
      include TemplateFormatters
      
      attr_accessor :groups
      
      def initialize(groups)
        @groups = groups.sort
        super File.dirname(__FILE__) + "/group_list.erb"
      end      
    end
  end
end
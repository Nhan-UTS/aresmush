module AresMUSH
  module Idle
    def self.can_idle_sweep?(actor)
      actor.has_any_role?(Global.read_config("idle", "roles", "can_idle_sweep"))
    end

    def self.is_exempt?(actor)
      actor.has_any_role?(Global.read_config("idle", "roles", "idle_exempt"))
    end
        
    def self.active_chars
      base_list = Character.where(:idled_out.exists => false, :idled_out.ne => "", :is_playerbit.ne => true)
      base_list.select { |c| !(Roles::Api.is_admin?(c) || Login::Api.is_guest?(c))}
    end
    
  end
end
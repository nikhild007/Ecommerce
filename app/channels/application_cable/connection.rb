module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # include Devise::Concerns::CurrentUser
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      else
        nil
      end
    end
  end
end
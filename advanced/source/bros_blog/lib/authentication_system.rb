module AuthenticationSystem
  
  def self.included(base)
    base.before_filter :extend_session
  end
  
  protected
  
    def extend_session
      class <<session
        def user=(user)
          self[:user] ||= {}
          if user.kind_of? ActiveRecord::Base
            self[:user][:id], self[:user][:class] = user.id, user.class.to_s
            @current_user ||= user
          else
            self[:user] = user
          end
        end
  
        def user
          @current_user ||= self[:user][:class].camelize.constantize.send(:find, self[:user][:id]) rescue nil
        end
      end
    end
  
end
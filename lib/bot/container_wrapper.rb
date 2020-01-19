# frozen_string_literal: true

class ContainerWrapper
  def self.proc_wrapper(&block)
    # Wrap the original proc
    Proc.new do |event, *args|
      # Handle the event with whatever extra
      # we want to do
      handle_event(event, args)

      # Call the original proc passed into #command
      block.call(event, *args)
    end
  end

  def self.handle_event(event, args)
    UserService.update_db_from_user(event.user)
  end
end

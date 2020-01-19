# frozen_string_literal: true

class BaseEventContainer
  extend Discordrb::EventContainer

  # User-related events:
  def self.message(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.typing(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.message_edit(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.message_delete(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.message_update(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.reaction_add(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.reaction_remove(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.reaction_remove_all(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.presence(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.playing(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.mention(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.channel_create(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.channel_update(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.channel_delete(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.channel_recipient_add(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.channel_recipient_remove(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.voice_state_update(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.member_join(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.member_update(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.member_leave(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.user_ban(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.user_unban(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end
  def self.pm(attributes = {}, &block)
    super(attributes, &proc_wrapper(&block))
  end

  # TODO: Add event shimming to these as well
  # Server-related events:
  # server_create
  # server_update
  # server_delete
  # server_emoji
  # server_emoji_create
  # server_emoji_delete
  # server_emoji_update
  # server_role_create
  # server_role_delete
  # server_role_update
  # webhook_update

  def self.proc_wrapper(&block)
    # Wrap the original proc
    Proc.new do |event|
      # Handle the event with whatever extra
      # we want to do
      handle_event(event)

      # Call the original proc passed into #command
      block.call(event)
    end
  end

  def self.handle_event(event)
    UserService.update_db_from_user(event.user)
  end
end

# TODO: Get this stuff working...

# events = [
#   :channel_create,
#   :channel_delete,
#   :playing
# ]

# def self.learn_maneuvering(name, &block)
#   pp "name: #{name}"
#   pp "&block: #{block}"

#   define_singleton_method(name) do |*args|
#     pp "args: #{args}"

#     # args.each do |arg|
#     block.call(args)
#     # end
#   end
# end

# self.singleton_class.send(:alias_method, :old_playing, :playing)

# self.learn_maneuvering(:playing) do |attributes = {}, &block|
#   pp "HERE"

#   klass = self.class
#   pp klass
#   klass = klass.superclass while !klass.singleton_methods(false).include?(:playing)

#   klass.playing(attributes, &proc_wrapper(&block))
#   pp "Should have run..."
# end

# self.learn_maneuvering(:playing) do |t|
#   pp "YEP"
#   pp t
# end

# pp 1
# self.playing(1234)
# pp 2

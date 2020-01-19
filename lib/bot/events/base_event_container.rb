# frozen_string_literal: true

class BaseEventContainer < ContainerWrapper
  extend Discordrb::EventContainer

  # TODO: Get define_method working for
  # an array of methods with the same signature

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
end

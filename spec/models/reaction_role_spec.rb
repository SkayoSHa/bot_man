# == Schema Information
#
# Table name: reaction_roles
#
#  id         :bigint           not null, primary key
#  reaction   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint           not null
#  role_id    :bigint           not null
#
require 'rails_helper'

RSpec.describe ReactionRole, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

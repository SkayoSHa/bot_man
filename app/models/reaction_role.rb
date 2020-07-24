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
class ReactionRole < ApplicationRecord
end

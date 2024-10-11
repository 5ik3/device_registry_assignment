# frozen_string_literal: true

class ApiKey < ApplicationRecord
  belongs_to :bearer, polymorphic: true

  validates :token, presence: true, uniqueness: true
  validates :bearer_type, presence: true
end

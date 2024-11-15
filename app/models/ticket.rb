class Ticket < ApplicationRecord
    has_many :messages, dependent: :destroy
end

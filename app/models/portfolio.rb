class Portfolio < ApplicationRecord
  belongs_to :user
  TAG_OPTIONS = ["rock","pop","pop","jazz","classique"]

  # Validation pour s'assurer que le tag est inclus dans la liste prédéfinie
  validates :tags, inclusion: { in: TAG_OPTIONS }
end

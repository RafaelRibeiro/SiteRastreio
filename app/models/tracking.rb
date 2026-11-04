class Tracking < ApplicationRecord
    validates :tracking_code, presence: true
    validates :tracking_code, uniqueness: { case_sensitive: false}

    has_many :histories, dependent: :destroy

    before_validation :normalize_tracking_code

    private

    # Evita salvar códigos com espaços acidentais e padroniza letras maiúsculas
    def normalize_tracking_code
        self.tracking_code = tracking_code&.strip&.upcase
    end
end

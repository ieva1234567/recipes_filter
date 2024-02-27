class User < ApplicationRecord

    lockbox_encrypts :private_api_key
    blind_index :private_api_key
  
    before_create :set_private_api_key
  
    validates :private_api_key, :email, uniqueness: true, allow_blank: false

  
    private
  
    def set_private_api_key
      self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
    end

end

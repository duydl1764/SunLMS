class Publisher < ApplicationRecord
	has_many :books

	before_save{ 	self.name = name.downcase 
					self.address = address.downcase	}

	validates :name, presence: true, length: { maximum: 40 },
				uniqueness: { case_sensitive: false }
	validates :address, presence: true, length: { maximum: 100 }
	validates :content, length: { maximum: 200 }
	
end

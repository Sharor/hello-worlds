class Location < ActiveRecord::Base
  belongs_to :region
  has_many :people

  def self.in_region(region)
    all.joins(:region).where("regions.name LIKE ?", "%#{region}%")
  end
end

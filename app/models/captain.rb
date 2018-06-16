class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' }).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: { name: 'Motorboat' }).uniq
  end

  def self.talented_seafarers
    self.sailors.pluck(:id).uniq & self.motorboat_operators.pluck(:id).uniq
  end

  def self.non_sailors
    includes(boats: :classifications).where.not(classifications: { name: 'Sailboat' }).pluck(:name).uniq
  end
end

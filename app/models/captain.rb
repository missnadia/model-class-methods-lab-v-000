class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' }).uniq
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.sailboat_operators
    includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: { name: 'Motorboat' }).uniq
  end

  def self.talented_seafarers
    where(self.sailboat_operators, self.motorboat_operators).pluck(:name)
  end

  def self.non_sailors
    includes(boats: :classifications).where.not(classifications: { name: 'Sailboat' }).pluck(:name).uniq
  end
end

class Season < ApplicationRecord
  belongs_to :studio

  validates :name, :start_year, :end_year, presence: true

  def year
    start_year == end_year ? start_year.to_s : "#{start_year} - #{end_year}"
  end
end

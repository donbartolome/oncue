class Season < ApplicationRecord
  belongs_to :studio

  validates :name, :start_year, :end_year, presence: true
  validate :start_year_not_greater_than_end_year

  def year
    start_year == end_year ? start_year.to_s : "#{start_year} - #{end_year}"
  end

  private

  def start_year_not_greater_than_end_year
    if start_year.present? && end_year.present? && start_year > end_year
      errors.add(:start_year, "cannot be greater than end year")
    end
  end
end

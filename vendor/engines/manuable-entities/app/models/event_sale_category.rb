class EventSaleCategory < ActiveRecord::Base
  attr_accessible :name, :price
  belongs_to :event

  def available_positions
    return [] if positions.blank?
    return @_avail_pos if !@_avail_pos.nil?
    @_avail_pos = []

    positions.split(',').each do |range_or_fix|
      numbers = range_or_fix.split('..').map(&:to_i)
      if numbers.length > 1
        @_avail_pos += (numbers[0]..numbers[1]).to_a
      else
        @_avail_pos << numbers[0]
      end
    end
    occupied_pos = event.event_payments.not_expired_or_paid.pluck :position
    @_avail_pos.compact!
    @_avail_pos.uniq!
    @_avail_pos.sort!
    @_avail_pos = @_avail_pos - occupied_pos
    @_avail_pos
  end

end

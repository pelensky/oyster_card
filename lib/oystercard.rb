require_relative "balance"

class Oystercard

  attr_reader :balance

  MAXIMUM_TOP_UP = 50

  def initialize
    @balance = Balance.new
    @touch_in = false
  end

  def top_up(number)
    raise "You can only top up a number." unless is_integer_or_float?(number)
    raise "You can't top up with a negative number." if number < 0
    raise "You can't top up 0." if number == 0
    raise "You can top up a maximum of #{MAXIMUM_TOP_UP}." if number > MAXIMUM_TOP_UP
    raise 'You can only top up numbers with a max. of 2 decimal places' unless has_no_more_than_two_decimal_places?(number)
    @balance.add_amount(number)
  end


  # redundant for now, but lets' keep it
  # so we can refer to it in future
  #
  # def deduct_fare(number)
  #   raise "You can only deduct a number." unless is_integer_or_float?(number)
  #   raise "You can not deduct a negative number." if number < 0
  #   raise "You can not deduct 0." if number == 0
  #   raise 'You can only deduct numbers with a max. of 2 decimal places' unless has_no_more_than_two_decimal_places?(number)
  #   @balance.deduct_amount(number)
  # end

  def has_no_more_than_two_decimal_places?(number)
    number == number.round(2)
  end

  def is_integer_or_float?(number)
    number.is_a?(Integer) || number.is_a?(Float)
  end

  def touch_in?
    @touch_in
  end

  def touch_in
    raise "Error. That card is already touched in." if touch_in?
    self.touch_in=(true)
  end

  def touch_out
    raise "Error. That card is touched out." if !touch_in?
    self.touch_in=(false)
  end

  private

    def touch_in=(boolean)
      @touch_in = boolean
    end

end

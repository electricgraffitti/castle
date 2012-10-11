class Currency

	def self.calculate_cents_to_dollars(amount)
		return (amount).to_i / 100.0
	end


	def self.calculate_dollars_to_cents(amount)
		split_values = amount.divmod 1
		dollars_to_cents = split_values[0].to_i * 100
		cents_to_flat = split_values[1] * 100
		total_cents = dollars_to_cents + cents_to_flat
		return (total_cents).to_i
	end

end
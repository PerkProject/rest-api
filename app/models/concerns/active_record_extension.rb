module ActiveRecordExtension
    def has_money_columns(*columns)
      columns.each do |column|
        define_method "#{column}_string" do
          public_send(column.to_s).try(:format)
        end
        define_method "#{column}_string=" do |value|
          self.public_send("#{column}=", value.presence)
        end
        composed_of column.to_sym,
          class_name: 'Money',
          mapping: {
            "#{column}" => 'price'
          },
          allow_nil: true,
          constructor: MONEY_CONSTRUCTOR,
          converter: MONEY_CONVERTER
      end
    end
    MONEY_CONSTRUCTOR = Proc.new do |price|
      Money.new(price)
    end
    MONEY_CONVERTER = Proc.new do |value|
      if value.is_a?(Hash)
        value["amount"] && value["amount"]
      elsif value.respond_to?(:to_money)
        value.to_money
      else
        raise ArgumentError, "Can't convert #{value.class} to Money"
      end
    end
  end
=begin
The Product Class is a class made for creating a new product quick and effortlessly without creating duplicate code

-productNumber is a string that holds the specific number for the product
-description is a string that holds the description of the produc
-cost is an integer to represent the cost of the product that the retail stored paid for it
-retail is a decimal that holds the retail price for the product
-quantityOnHand is a number that holds the amount in stock of the product. CANNOT BE LESS THAN 0
=end

class Product
    def initialize(productNumber, description, cost, retail, quantityOnHand)
        @productNumber = productNumber
        @description = description
        @cost = cost
        @retail = retail
        @quantityOnHand = quantityOnHand
    end

    # display method
    def display
        puts "===================="
        puts "Product Number:".ljust(30) + "#{@productNumber}"
        puts "Description:".ljust(30) + "#{@description}"
        puts "Cost For Retailer:".ljust(30) + "#{@cost}"
        puts "Retail Price:".ljust(30) + "#{@retail}"
        puts "Quantity In Stock:".ljust(30) + "#{@quantityOnHand}"
        puts "===================="
    end

    # changing the property for in stock
    def updateStockCount(quantityOnHand)
        @quantityOnHand = quantityOnHand
    end

    # Returning certain properties for easy use  
    def productNumber
        @productNumber
    end

    def quantityOnHand
        @quantityOnHand
    end

    def retail
        @retail
    end
end
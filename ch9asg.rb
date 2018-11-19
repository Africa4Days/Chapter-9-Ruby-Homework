=begin
Chris Bell
Computer Science 1
Retailer Program
=end

require_relative 'Product'

$products = []
$productsInStock = []
$exitProgram = false
$next = false

# create a new product
def createProduct()
    while $next != true
        puts "What is the product number?"
        productNumber = gets.chomp

        canWeUseThisNum(productNumber)
    end

    $next = false

    puts "What is the description of the product"
    description = gets.chomp

    while $next != true
        puts "What is the cost of the product for the store to purchase?"
        cost = gets.chomp.to_f

        if cost < 0.01
            puts "Cost cannot be 0. Please enter a valid cost."
        else 
            $next = true
        end
    end

    $next = false

    while $next != true
        puts "What is the cost of the item being sold at retail?"
        retail = gets.chomp.to_f

        if retail < 0.01
            puts "Retail cost cannot be 0. Please enter a valid cost."
        else
            $next = true
        end
    end

    $next = false

    while $next != true
        puts "How many are in stock?"
        quantityOnHand = gets.chomp.to_i

        if quantityOnHand < 0
            puts "Quantity cannot be below 0. Please enter a valid quantity."
        else
            $next = true
        end
    end

    $next = false

    product = Product.new(productNumber, description, cost, retail, quantityOnHand)

    $products.push(product)

    puts "PRODUCT CREATED"
end

# search for a product
def searchForProduct(productNumber)
    for product in $products
        if product.productNumber == productNumber
            puts "Product found"
            product.display
            return true
        else
            puts "No product was found under product number #{productNumber}."
            return false
        end
    end
end

# display all the products whose quantityOnHand is above 0
def displayProducts
    createProductsInStockArray()

    for product in $products
        puts "HERE IS A LIST OF THE PRODUCTS IN STOCK:"
        product.display
        puts "---------"
    end
end

# go through all the products and create an array of the products that the retailer has in stock
def createProductsInStockArray
    for product in $products
        if product.quantityOnHand > 0
            $productsInStock.push(product)
        end
    end
end

# purchase a product
def purchaseAProduct(productNumber, amountToPurchase)
    for product in $products
        if product.productNumber == productNumber
            if product.quantityOnHand < amountToPurchase
                return false
            else
                stock = product.quantityOnHand - amountToPurchase
                product.updateStockCount(stock)
                displayReceipt(product.retail, amountToPurchase)
                return true
            end
        end
    end
end

# display receipt
def displayReceipt(costOfProduct, amountPurchased)
    subtotal = costOfProduct * amountPurchased
    salesTax = (subtotal * 1.06) - subtotal
    grandTotal = subtotal + salesTax

    puts "Subtotal:".ljust(30) + "#{subtotal}"
    puts "Sales Tax:".ljust(30) + "#{salesTax}"
    puts "Grand Total:".ljust(30) + "#{grandTotal}"
end

# process user answer and see what to do next
def processAnswer(userAnswer)
    if userAnswer == 1
        createProduct()
    elsif userAnswer == 2
        puts "Please enter the product number you would like to search for"
        userNumber = gets.chomp
        searchForProduct(userNumber)
    elsif userAnswer == 3
        displayProducts()
        while $next != true
            puts "Please enter a product number from that list that you wish to purchase."
            productNumToPurchase = gets.chomp

            if searchForProduct(productNumToPurchase) == true
                puts "How many of that product would you like to purchase?"
                amountOfProductToPurchase = gets.chomp.to_i

                if purchaseAProduct(productNumToPurchase, amountOfProductToPurchase) == false
                    puts "Amount to purchase cannot exceed the amount in stock."
                else
                    $next = true
                end
            else
                puts "No product number in that list matches the product number entered."
            end
        end

        $next = false
        
    elsif userAnswer == 4
        puts "Bye!"
        $exitProgram = true
    else 
        puts "Incorrect choice, try again"
    end
end

# function for checking if the product number being created already exists
def canWeUseThisNum(num)
    if $products.count < 1
        $next = true
    else 
        for product in $products
            if product.productNumber == num
                puts "#{num} already in use. Please enter a different number."
            else
                puts "Product number accepted."
                $next = true
            end
        end
    end
end

# Starting the program

while $exitProgram != true
    puts "##########\nWhat would you like to do?\n1. Create a new product (enter 1)\n2. Look up a product (enter 2)\n3. Process a product purchase (enter 3)\n4. Exit (enter 4)\n##########"
        userChoice = gets.chomp.to_i
        processAnswer(userChoice)
end
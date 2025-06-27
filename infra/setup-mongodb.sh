#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y

#From a terminal, install gnupg and curl if they are not already available
sudo apt-get install gnupg curl

#To import the MongoDB public GPG key, run the following command
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor


#Create the list file /etc/apt/sources.list.d/mongodb-enterprise-8.0.list for your version of Ubuntu.
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.com/apt/ubuntu noble/mongodb-enterprise/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise-8.0.list

#Reload the package database
sudo apt-get update

#Install MongoDB Enterprise Server
sudo apt-get install -y mongodb-enterprise

# Start MongoDB service
echo "Starting MongoDB service..."
sudo systemctl start mongod

# Enable MongoDB to start on boot
sudo systemctl enable mongod

# Wait 10s for MongoDB to fully get started
sleep 10

# Create a MongoDB database called "product" and a collection called "products"
echo "Setting up MongoDB database and collection..."

mongosh <<EOF
use product;
db.createCollection("products");
db.products.insertMany([
  { name: "iPhone 18 pro", price: 200, quantity: 4 },
  { name: "Samsung Pro", price: 150, quantity: 13 },
  { name: "Tesla Pi", price: 180, quantity: 7 },
]);
print("Database and collection created successfully with 3 dummy products.");
EOF

# Display the inserted products
echo "Displaying the inserted products in the collection:"
mongosh <<EOF
use product;
printjson(db.products.find().toArray());
EOF

echo "MongoDB setup completed successfully!"
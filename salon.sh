#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

function MAIN_MENU () {
SERVICES=$($PSQL "SELECT * FROM services")
echo "$SERVICES" | while read service_id BAR NAME
do
echo -e "$service_id) $NAME"
done
read SERVICE_ID_SELECTED

case $SERVICE_ID_SELECTED in
1) BOOKING "$SERVICE_ID_SELECTED";;
2) BOOKING "$SERVICE_ID_SELECTED";;
3) BOOKING "$SERVICE_ID_SELECTED";;
*) MAIN_MENU ;;
esac



}

BOOKING() {
echo -e "\nWhat is your Phone number?"
read CUSTOMER_PHONE
PHONE_NUMBER_RESULT=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'") 
if [[ -z $PHONE_NUMBER_RESULT ]]
then
  echo -e "\nWhat is your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
fi
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
echo -e "\nWhat time do you want your appointment?"
read SERVICE_TIME
INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES('$CUSTOMER_ID','$1','$SERVICE_TIME')")
if [[ ! -z INSERT_APPOINTMENT_RESULT ]]
then
SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$1")
echo -e "I have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
fi




}

MAIN_MENU

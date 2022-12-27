#/usr/bin/bash
source create.sh
source connect.sh
source list.sh
source drop.sh
if [ -e ./Databases ];then
            cd Databases
        else
            mkdir Databases
            cd Databases
fi
select option in "createDB" "listDB" "ConnectDB" "DropDB" "Exit"
do
echo $option
case $option in 
createDB )
Create_database
;;                
listDB ) 
listing_Databases
;;
ConnectDB )
echo "Enter Name of DB "
read name
echo $name 
if [ -d $name ] ; then 
cd $name
select y in create_tables list_tables drop insert Select delete_data update exitt
do
case $y in 
create_tables )
create_table
;;
list_tables )
listing_tables
;;
drop )
drop_table
;;
delete_data )
delete_from_table
;;
update )
updatee
;;
insert )
insert_into_table
;;
Select )
select_from_table
;;
exitt )
break
;;
esac
done 
else 	
echo "Sorry DataBase Not Exit "
fi
;;
DropDB ) 
droppingDataBase
;;                
Exit )
echo "breakkk" 
break
;;
esac
done

 

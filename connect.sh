function listing_tables()
{
    ls -I "*.md" #listing all tables excpet metadata
}

function dataType()
{
    select stint in "String" "Integer"
        do
        case $stint in
            "String")
            echo -n "$stint:" >> "$table_name.md"
            break
            ;;
            "Integer")
            echo -n "$stint:" >> "$table_name.md"
            break
            ;;
            * )
            echo " please enter option 1 or 2 only"
            ;;
        esac
        done
}
function checkUnique(){
awk -F':' -v value=$1 '{ 
 if(NR!=1){     
    if($1==value){ 
        print(1);
        }
}
} ' "$2"
}


function create_table()
{
	echo "pleas enter table name"
    	read table_name
    	while [[ ! $table_name =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]];
        	do
        	 echo "pleas enter a valid name choose 5 to Exit"
        	 read table_name
        	done
    	while [ -e $table_name ];
        	do
        	    echo "This table is already exist,please enter another name"
        	    read table_name
        	done
    	touch $table_name 
    	touch "$table_name.md"
    	echo "please enter the number of columns"
    	read number
    	while [[ ! $number =~ [0-99]+$ ]];
    	    do
    	    echo "please enter a valid number"
    	    read number
    	    done
    for i in $( seq 1 $number);
        do
            if (( $i==1 ));
                then echo "please enter the primary key in column $i"
                    read pk
                    echo "please enter type of key string/int"
                    select opt in string int 
                    do
                    case $opt in 
                    string )
                    echo "string "
                    break
                    ;;
                    int )
                    echo "int "
                    break
                    ;;
                    * )
                    echo "error"
                    ;;
                    esac
                    done
                echo -n "$pk:" > $table_name
                echo -n "$stint:" > "$table_name.md"
            else   
                echo "please enter column name in column $i" 
                read variable
                echo "please enter type of column string/int"
                select opt in string int 
                    do
                    case $opt in 
                    string )
                    echo "string "
                    break
                    ;;
                    int )
                    echo "int "
                    break
                    ;;
                    * )
                    echo "error"
                    ;;
                    esac
                    done
                echo -n "$variable:" >> $table_name
                echo -n "$stint:" >> "$table_name.md"
                
            fi
        done
    
}
      
function insert()
{
echo "please enter table name"
    read table2
declare -i number=$(head -n1 "$table2.md" | awk -F : '{print NF-1 ;}')
for i in $(seq 1 $number);
    do
        col_name=$(head -n1 $table2 | sed  $'s/:/ /g' | awk -v i=$i -F " " '{ print $i }')
        col_type=$(head -n1 $table2.md | sed  $'s/:/ /g' | awk -v i=$i -F " " '{ print $i }')
        while [ -e $table2 ]
        do
            echo "please enter the $col_name" 
            read x
             if (( $i==1 ));
            then   
                var=$(checkUnique $x $table2)
                while [ "$var" = 1 ]
                do
                    echo "pk is not unique"
                    read x
                    var=$(checkUnique $x $table2) 
                done
            fi
            if [ "$col_type" = "Integer" ] && [[ $x =~ [0-99]+$ ]]
                then echo -n  "$x:" >> $table2
                break
            elif [ "$col_type" = "String" ]
                then echo -n  "$x:" >> $table2
                break
            else
                echo "type is not matched, type = $col_type"
                continue 
            fi
        done
        if (( $i==$number ));
        then   
            echo "" >> $table2
        fi
    done
}
function drop_table()
{  
echo enter the name of the table to Delete
read tablee
if [ -f tablee ]; then
  rm  $tablee
  echo "table Deleted successfuly"
else
  echo "table not existed"
fi
}




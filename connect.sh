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

function selectype ()
{
select stint in "Integer" "String"
do
case $stint in 
"Integer" )  
echo -n "$stint:" >> "$table_name.md"
break
;;
"String" ) 
 echo -n "$stint:" >> "$table_name.md"
break
;;
* ) echo "please enter a valid datatype"  
;;
esac
done
}
function create_table()
{   
   echo "please enter table name"
    read table_name
    while [[ ! $table_name =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]];
        do
         echo "please enter a valid name "
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
    read num
    while [[ ! $num =~ [0-99]+$  ]]
        do
        echo "please enter a valid number"
        read num
        echo "$num"
        done   
    for i in $( seq 1 $num);
        do
            
            if (( $i==1 ));
                then 
                    echo "please enter the primary key name"
                    read pk
                    while [[ ! $pk =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]];
                        do 
                            echo "please enter a valid column name"
                            read pk
                        done
                    echo "please enter type of key string/int"
                    selectype
                echo -n "$pk:" >> $table_name
            else   
                echo "please enter column name"
                read variable
                while [[ ! $variable =~ ^([a-zA-Z\_])+([a-zA-Z0-9\_])*$ ]];
                do 
                    echo "please enter a valid column name"
                    read variable
                done
               
                echo "please enter type of column string/int"
                    selectype
                echo -n "$variable:" >> $table_name
                
            fi
            if (( $i==$num ));
            then   
                echo "" >> $table_name
            fi
        done
}

function validate_unique(){
awk -F':' -v value=$1 '{ 
 if(NR!=1){     
    if($1==value){ 
        print(1);
        }
}
} ' "$2"
}
function insert_into_table()
{
    echo "please enter table name"
    read -r table2
    while [ ! -e $table2 ]
        do
            echo "table doesnt exist , try again or exit"
            read -r table2
            if [ $table2 == 'exit' ]
                then break
            fi
        done
    declare -i number=$(head -n1 "./$table2.md" | awk -F : '{print NF-1 ;}')

    for i in $(seq 1 $number);
    do
        col_name=$(head -n1 $table2 | sed  $'s/:/ /g' | awk -v i=$i -F " " '{ print $i }')
        col_type=$(head -n1 $table2.md | sed  $'s/:/ /g' | awk -v i=$i -F " " '{ print $i }')
        # echo "$col_name"
        # echo "$col_type"


        while [ -e $table2 ]
        do
            echo "please enter the $col_name" 
            read -r x
            if (( $i==1 ));
            then   
                var=$(validate_unique $x $table2)
                while [ "$var" = 1 ]
                do
                    echo "pk is not unique"
                    read -r x
                    var=$(validate_unique $x $table2) 
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
if [ -f $tablee ]; then
  rm  $tablee
  echo "table Deleted successfuly"
else
  echo "table not existed"
fi
}
function delete_from_table()
{
echo "Enter the table name: " 
read table
if [[ ! -e $table ]];then
    echo "error table not found"
else
    cat $table
echo "Enter a word to delete: "
read word
echo "Enter the line number: "
read line
sed -i "${line}s/\b$word\b//" $table
cat $table
fi
}      
function updatee()
{
    echo "Enter the table name : "
    read table1
    if ! [[ -e $table1 ]];then
        echo "error doesnt exist"
    else
    cat $table1

    echo "Enter the line number:"
    read line_number

    echo "Enter the word number:"
    read word_number

    echo "Enter the word to replace:"
    read word_to_replace

    echo "Enter the replacement word:"
    read replacement_word
    awk -v line_number="$line_number" \
        -v word_number="$word_number" \
        -v replacement_word="$replacement_word" \
        'NR == line_number {
        split($0, a, ":");
        a[word_number] = replacement_word;
        print a[1] ":" a[2] ":" a[3] ":" a[4]
        } NR != line_number' "$table1" > "$table1.tmp" && mv "$table1.tmp" "$table1"

        echo "table is updated " && cat $table1

fi



}

function select_from_table
{
    echo "enter table name : "
    read table
    if ! [[ -e $table ]];then
        echo "error doesnt exist"
    else
    select choice in all selects_items
    do
    case $choice in
    all )
        cat $table
    break
    ;;
    selects_items )
        cat $table
        echo "    "
        echo "Enter field number: "
        read field_num
        awk -F : -v num=$field_num '{ print $num }' $tableee   
    break
    ;;
esac
done
fi
}



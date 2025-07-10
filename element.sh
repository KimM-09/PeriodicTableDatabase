PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
    then
        echo Please provide an element as an arguement.

    else
        if [[ $1 =~ ^[0-9]+$ ]]
            then
                RESULT=$($PSQL "SELECT * FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1")
            if [[ -z $RESULT ]]
                then
                    echo I could not find that element in the database.
                else
                    echo "$RESULT" | while IFS=\| read TYPE_ID ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL NAME TYPE
                        do
                            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
                    done
            fi
        fi
fi
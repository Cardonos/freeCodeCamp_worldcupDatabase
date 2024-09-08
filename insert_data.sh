#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat ./games.csv | while IFS="," read DATE TYPE WINNER OPP WINGOAL OPPGOAL
do
  if [[ $DATE != 'year' ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")
    if [[ $WINNER_ID = "" ]]
      then
      echo "$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")"
      fi
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPP';")
    if [[ $OPP_ID = "" ]]
      then
      echo "$($PSQL "INSERT INTO teams(name) VALUES('$OPP');")"
      fi
    fi
done

cat ./games.csv | while IFS="," read DATE TYPE WINNER OPP WINGOAL OPPGOAL
do
  if [[ $DATE != 'year' ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPP';")
    echo "$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($DATE, '$TYPE', $WINNER_ID, $OPP_ID, $WINGOAL, $OPPGOAL);")"
  fi
done
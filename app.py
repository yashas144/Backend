from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector #type: ignore
from mysql.connector import Error #type: ignore

#This is backend developed by yashas chandra

# made Rest call using Flask API
app = Flask(__name__)
CORS(app)

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'Hanuman$9',
    'database': 'Sportsdb'
}

# --- EXISTING GET ALL PLAYERS ROUTE (MODIFIED) ---
# I've added PlayerID to the SELECT statement, which is needed for the edit link.
@app.route('/api/players', methods=['GET'])
def get_players():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        # IMPORTANT: Added PlayerID to the query
        query = "SELECT PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored FROM PlayerInfo ORDER BY PlayerID DESC"
        cursor.execute(query)
        players = cursor.fetchall()
        for player in players:
            if player.get('DOB'):
                player['DOB'] = player['DOB'].isoformat()
        return jsonify(players)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

# --- NEW: GET A SINGLE PLAYER BY ID ---
@app.route('/api/players/<int:player_id>', methods=['GET'])
def get_player(player_id):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        query = "SELECT PlayerID, PlayerName, Age, DOB, Gender, TotalGoalsScored FROM PlayerInfo WHERE PlayerID = %s"
        cursor.execute(query, (player_id,))
        player = cursor.fetchone()
        
        if player and player.get('DOB'):
            player['DOB'] = player['DOB'].isoformat().split('T')[0] # Format as YYYY-MM-DD
            
        return jsonify(player) if player else ('', 404)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

# --- EXISTING ADD PLAYER ROUTE (UNCHANGED) ---
@app.route('/api/addplayer', methods=['POST'])
def add_player():
    data = request.get_json()
    if not data or not data.get('PlayerName') or not data.get('Age') or not data.get('DOB'):
        return jsonify({"error": "Please provide all required fields."}), 400
    query = """
        INSERT INTO PlayerInfo (PlayerName, Age, DOB, Gender, TotalGoalsScored) 
        VALUES (%s, %s, %s, %s, %s)
    """
    args = (data.get('PlayerName'), data.get('Age'), data.get('DOB'), data.get('Gender'), data.get('TotalGoalsScored', 0))
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Player added successfully!"}), 201
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to add player to the database."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

# --- NEW: UPDATE AN EXISTING PLAYER ---
@app.route('/api/players/<int:player_id>', methods=['PUT'])
def update_player(player_id):
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data provided."}), 400
        
    query = """
        UPDATE PlayerInfo 
        SET PlayerName=%s, Age=%s, DOB=%s, Gender=%s, TotalGoalsScored=%s 
        WHERE PlayerID=%s
    """
    args = (
        data.get('PlayerName'),
        data.get('Age'),
        data.get('DOB'),
        data.get('Gender'),
        data.get('TotalGoalsScored', 0),
        player_id
    )
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Player updated successfully!"})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to update player."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- NEW: DELETE AN EXISTING PLAYER ---
@app.route('/api/players/<int:player_id>', methods=['DELETE'])
def delete_player(player_id):
    query = "DELETE FROM PlayerInfo WHERE PlayerID = %s"
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, (player_id,))
        conn.commit()
        # Check if any row was actually deleted
        if cursor.rowcount == 0:
            return jsonify({"error": "Player not found or already deleted."}), 404
        return jsonify({"message": "Player deleted successfully!"}), 200
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to delete player."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- TEAM MANAGEMENT ENDPOINTS ---

@app.route('/api/teams', methods=['GET'])
def get_teams():
    """Endpoint to retrieve all teams with manager names."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        # Join with Users table to get manager's name
        query = """
            SELECT T.*, CONCAT(U.UserFirstName, ' ', U.UserLastName) AS ManagerName 
            FROM TeamInfo T
            LEFT JOIN Users U ON T.ManagerID = U.UserID
            ORDER BY T.TeamID
        """
        cursor.execute(query)
        teams = cursor.fetchall()
        return jsonify(teams)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/teams/<int:team_id>', methods=['GET'])
def get_team(team_id):
    """Endpoint to retrieve a single team by ID."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM TeamInfo WHERE TeamID = %s", (team_id,))
        team = cursor.fetchone()
        return jsonify(team) if team else ('', 404)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/teams', methods=['POST'])
def add_team():
    """Endpoint to add a new team."""
    data = request.get_json()
    query = """
        INSERT INTO TeamInfo (TeamName, Country, NumOfMatchesPlayed, MatchesWon, MatchesLost, MatchesTie, TotalGoalsScored, ManagerID) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """
    args = (
        data.get('TeamName'), data.get('Country'), data.get('NumOfMatchesPlayed'), 
        data.get('MatchesWon'), data.get('MatchesLost'), data.get('MatchesTie'), 
        data.get('TotalGoalsScored'), data.get('ManagerID')
    )
    # ... (try/except/finally block for execution, same as add_player)
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Team added successfully!"}), 201
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to add team."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route('/api/teams/<int:team_id>', methods=['PUT'])
def update_team(team_id):
    """Endpoint to update an existing team."""
    data = request.get_json()
    query = """
        UPDATE TeamInfo SET TeamName=%s, Country=%s, NumOfMatchesPlayed=%s, MatchesWon=%s, 
        MatchesLost=%s, MatchesTie=%s, TotalGoalsScored=%s, ManagerID=%s 
        WHERE TeamID=%s
    """
    args = (
        data.get('TeamName'), data.get('Country'), data.get('NumOfMatchesPlayed'),
        data.get('MatchesWon'), data.get('MatchesLost'), data.get('MatchesTie'),
        data.get('TotalGoalsScored'), data.get('ManagerID'), team_id
    )
    # ... (try/except/finally block for execution)
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Team updated successfully!"})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to update team."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/teams/<int:team_id>', methods=['DELETE'])
def delete_team(team_id):
    """Endpoint to delete a team."""
    query = "DELETE FROM TeamInfo WHERE TeamID = %s"
    # ... (try/except/finally block for execution)
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, (team_id,))
        conn.commit()
        return jsonify({"message": "Team deleted successfully!"})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to delete team."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- USERS ENDPOINT (for manager dropdown) ---
@app.route('/api/users', methods=['GET'])
def get_users():
    """Endpoint to retrieve users to act as managers."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        # You might want to filter by UserRole = 'Manager' in a real app
        cursor.execute("SELECT UserID, CONCAT(UserFirstName, ' ', UserLastName) AS FullName FROM Users ORDER BY FullName")
        users = cursor.fetchall()
        return jsonify(users)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- MATCH MANAGEMENT ENDPOINTS ---

@app.route('/api/matches', methods=['GET'])
def get_matches():
    """Endpoint to retrieve all matches."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM MatchInfo ORDER BY MatchDate DESC"
        cursor.execute(query)
        matches = cursor.fetchall()
        # Ensure date objects are converted to strings for JSON
        for match in matches:
            if match.get('MatchDate'):
                match['MatchDate'] = match['MatchDate'].isoformat()
        return jsonify(matches)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/matches/<int:match_id>', methods=['GET'])
def get_match(match_id):
    """Endpoint to retrieve a single match by ID."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM MatchInfo WHERE MatchID = %s"
        cursor.execute(query, (match_id,))
        match = cursor.fetchone()
        if match and match.get('MatchDate'):
            match['MatchDate'] = match['MatchDate'].isoformat().split('T')[0]
        return jsonify(match) if match else ('', 404)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/matches', methods=['POST'])
def add_match():
    """Endpoint to add a new match."""
    data = request.get_json()
    query = "INSERT INTO MatchInfo (MatchName, Venue, MatchDate) VALUES (%s, %s, %s)"
    args = (data.get('MatchName'), data.get('Venue'), data.get('MatchDate'))
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Match added successfully!"}), 201
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to add match."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/matches/<int:match_id>', methods=['PUT'])
def update_match(match_id):
    """Endpoint to update an existing match."""
    data = request.get_json()
    query = "UPDATE MatchInfo SET MatchName=%s, Venue=%s, MatchDate=%s WHERE MatchID=%s"
    args = (data.get('MatchName'), data.get('Venue'), data.get('MatchDate'), match_id)
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Match updated successfully!"})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to update match."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/matches/<int:match_id>', methods=['DELETE'])
def delete_match(match_id):
    """Endpoint to delete a match."""
    query = "DELETE FROM MatchInfo WHERE MatchID = %s"
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, (match_id,))
        conn.commit()
        return jsonify({"message": "Match deleted successfully!"})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to delete match."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

# --- PLAYER AWARDS MANAGEMENT ENDPOINTS ---

@app.route('/api/player-awards', methods=['GET'])
def get_player_awards():
    """Endpoint to retrieve all player awards with relevant names."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT 
                PA.ID, PA.AwardName, PA.DateofAward,
                P.PlayerName, T.TeamName, M.MatchName
            FROM PlayerAwards PA
            LEFT JOIN PlayerInfo P ON PA.PlayerID = P.PlayerID
            LEFT JOIN TeamInfo T ON PA.TeamID = T.TeamID
            LEFT JOIN MatchInfo M ON PA.MatchID = M.MatchID
            ORDER BY PA.DateofAward DESC
        """
        cursor.execute(query)
        awards = cursor.fetchall()
        for award in awards:
            if award.get('DateofAward'):
                award['DateofAward'] = award['DateofAward'].isoformat()
        return jsonify(awards)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/player-awards/<int:award_id>', methods=['GET'])
def get_player_award(award_id):
    """Endpoint to retrieve a single player award."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM PlayerAwards WHERE ID = %s", (award_id,))
        award = cursor.fetchone()
        if award and award.get('DateofAward'):
            award['DateofAward'] = award['DateofAward'].isoformat().split('T')[0]
        return jsonify(award) if award else ('', 404)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/player-awards', methods=['POST'])
def add_player_award():
    """Endpoint to add a new player award."""
    data = request.get_json()
    query = "INSERT INTO PlayerAwards (MatchID, PlayerID, TeamID, AwardName, DateofAward) VALUES (%s, %s, %s, %s, %s)"
    args = (data.get('MatchID'), data.get('PlayerID'), data.get('TeamID'), data.get('AwardName'), data.get('DateofAward'))
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Player award added successfully!"}), 201
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to add award."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/player-awards/<int:award_id>', methods=['PUT'])
def update_player_award(award_id):
    """Endpoint to update a player award."""
    data = request.get_json()
    query = "UPDATE PlayerAwards SET MatchID=%s, PlayerID=%s, TeamID=%s, AwardName=%s, DateofAward=%s WHERE ID=%s"
    args = (data.get('MatchID'), data.get('PlayerID'), data.get('TeamID'), data.get('AwardName'), data.get('DateofAward'), award_id)
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, args)
        conn.commit()
        return jsonify({"message": "Player award updated successfully!"})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to update award."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

@app.route('/api/player-awards/<int:award_id>', methods=['DELETE'])
def delete_player_award(award_id):
    """Endpoint to delete a player award."""
    query = "DELETE FROM PlayerAwards WHERE ID = %s"
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute(query, (award_id,))
        conn.commit()
        return jsonify({"message": "Player award deleted successfully!"})
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to delete award."}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- PLAYER HISTORY ENDPOINT ---

@app.route('/api/player-history/<int:player_id>', methods=['GET'])
def get_player_history(player_id):
    """Endpoint to retrieve the match history for a single player."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        # This query joins TeamInfo twice to get both the player's team and the opponent's team name
        query = """
            SELECT 
                PH.MatchDate,
                PH.MatchResult,
                PH.GoalsScored,
                T1.TeamName AS TeamName,
                T2.TeamName AS PlayedAgainst
            FROM PlayerHistory PH
            JOIN TeamInfo T1 ON PH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON PH.PlayedAgainst = T2.TeamID
            WHERE PH.PlayerID = %s
            ORDER BY PH.MatchDate DESC
        """
        cursor.execute(query, (player_id,))
        history = cursor.fetchall()

        # Format date objects for JSON compatibility
        for record in history:
            if record.get('MatchDate'):
                record['MatchDate'] = record['MatchDate'].isoformat().split('T')[0]

        return jsonify(history)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- MATCH HISTORY ENDPOINT ---

@app.route('/api/match-history/<int:match_id>', methods=['GET'])
def get_match_history(match_id):
    """Endpoint to retrieve the history for a single match."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        # This query joins TeamInfo twice to get both team names
        query = """
            SELECT 
                MH.MatchResult,
                T1.TeamName,
                T2.TeamName AS PlayedAgainst
            FROM MatchHistory MH
            JOIN TeamInfo T1 ON MH.TeamID = T1.TeamID
            JOIN TeamInfo T2 ON MH.PlayedAgainst = T2.TeamID
            WHERE MH.MatchID = %s
        """
        cursor.execute(query, (match_id,))
        history = cursor.fetchall()
        return jsonify(history)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- TEAM HISTORY ENDPOINT ---

@app.route('/api/team-history/<int:team_id>', methods=['GET'])
def get_team_history(team_id):
    """Endpoint to retrieve the match history for a single team."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT 
                TH.MatchDate,
                TH.MatchResult,
                TH.GoalsScored,
                T.TeamName AS PlayedAgainst
            FROM TeamHistory TH
            JOIN TeamInfo T ON TH.PlayedAgainst = T.TeamID
            WHERE TH.TeamID = %s
            ORDER BY TH.MatchDate DESC
        """
        cursor.execute(query, (team_id,))
        history = cursor.fetchall()
        
        # Format date objects for JSON compatibility
        for record in history:
            if record.get('MatchDate'):
                record['MatchDate'] = record['MatchDate'].isoformat().split('T')[0]

        return jsonify(history)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

# --- PLAYER AWARDS SUMMARY ENDPOINT ---

@app.route('/api/player-awards-summary/<int:player_id>', methods=['GET'])
def get_player_awards_summary(player_id):
    """Endpoint to retrieve all awards for a single player."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        query = """
            SELECT PA.AwardName, PA.DateofAward, M.MatchName
            FROM PlayerAwards PA
            JOIN MatchInfo M ON PA.MatchID = M.MatchID
            WHERE PA.PlayerID = %s
            ORDER BY PA.DateofAward DESC
        """
        cursor.execute(query, (player_id,))
        awards = cursor.fetchall()
        
        # Format date objects for JSON compatibility
        for award in awards:
            if award.get('DateofAward'):
                award['DateofAward'] = award['DateofAward'].isoformat().split('T')[0]

        return jsonify(awards)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


# --- AUTHENTICATION & PROFILE ENDPOINTS ---

@app.route('/api/login', methods=['POST'])
def login():
    """Endpoint to handle user login."""
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    # WARNING: Plaintext password comparison. Do not use in production!
    query = """
        SELECT UserID, UserFirstName, UserLastName, UserRole 
        FROM Users 
        WHERE UserName = %s AND UserPassword = %s AND (UserRole = 'Player' OR UserRole = 'Manager')
    """
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query, (username, password))
        user = cursor.fetchone()

        if user:
            # User found and credentials are correct
            return jsonify(user), 200
        else:
            # Invalid credentials or role
            return jsonify({"error": "Invalid username, password, or role."}), 401

    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


@app.route('/api/users/<int:user_id>', methods=['GET'])
def get_user_profile(user_id):
    """Endpoint to get a user's full profile information."""
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        query = "SELECT UserID, UserName, UserFirstName, UserLastName, UserRole, Email, Mobile FROM Users WHERE UserID = %s"
        cursor.execute(query, (user_id,))
        profile = cursor.fetchone()
        
        return jsonify(profile) if profile else ('', 404)
    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

# Make sure these routes are added before the if __name__ == '__main__': block

if __name__ == '__main__':
    app.run(port=3001, debug=True)
















'''from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector # type: ignore
from mysql.connector import Error # type: ignore

# 1. Initialize the Flask App
app = Flask(__name__)
CORS(app)  # Enable Cross-Origin Resource Sharing

# 2. Database Configuration
# Replace with your actual MySQL database credentials
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'Hanuman$9',
    'database': 'Sportsdb'
}

# 3. Define API Routes (Endpoints)

@app.route('/api/players', methods=['GET'])
def get_players():
    """Endpoint to retrieve all players."""
    try:
        conn = mysql.connector.connect(**db_config)
        # dictionary=True makes the database return rows as dictionaries (like JSON)
        cursor = conn.cursor(dictionary=True)
        
        query = "SELECT PlayerName, Age, DOB, Gender, TotalGoalsScored FROM PlayerInfo ORDER BY PlayerID DESC"
        cursor.execute(query)
        
        players = cursor.fetchall()
        
        # Format the DOB field to be a string
        for player in players:
            if player['DOB']:
                player['DOB'] = player['DOB'].isoformat()
                
        return jsonify(players)

    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Database error"}), 500
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


@app.route('/api/players', methods=['POST'])
def add_player():
    """Endpoint to add a new player."""
    data = request.get_json() # Get data sent from the React form

    # Basic validation
    if not data or not data.get('PlayerName') or not data.get('Age') or not data.get('DOB'):
        return jsonify({"error": "Please provide all required fields."}), 400

    query = """
        INSERT INTO PlayerInfo (PlayerName, Age, DOB, Gender, TotalGoalsScored) 
        VALUES (%s, %s, %s, %s, %s)
    """
    args = (
        data.get('PlayerName'),
        data.get('Age'),
        data.get('DOB'),
        data.get('Gender'),
        data.get('TotalGoalsScored', 0) # Default to 0 if not provided
    )
    
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        
        cursor.execute(query, args)
        conn.commit() # Commit the transaction to save the changes
        
        return jsonify({"message": "Player added successfully!"}), 201

    except Error as e:
        print(f"Error: {e}")
        return jsonify({"error": "Failed to add player to the database."}), 500
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

# 4. Run the Flask App
if __name__ == '__main__':
    # Use port 3001 to match the original Node.js server
    app.run(port=3001, debug=True)'''